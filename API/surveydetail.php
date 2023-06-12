<?php
include 'config.php';
if (isset($_GET['id_survey'])) {
    // Lấy giá trị của biến 'id'
    $id = urldecode($_GET['id_survey']);
    //  echo $id; // In ra giá trị của biến 'id'

    // Kết nối tới CSDL
    $conn = sqlsrv_connect($serverName, $connectionOptions);

    if ($conn === false) {
        die(print_r(sqlsrv_errors(), true));
    }

    $query = "SELECT id_question, contents FROM question WHERE id_survey = ?";
    $params = array($id);
    $result = sqlsrv_query($conn, $query, $params);

    if ($result === false) {
        die(print_r(sqlsrv_errors(), true));
    }

    $questionsid = array();
    $questions_content = array();
    while ($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
        $questionsid[] = $row['id_question'];
        $questions_content[] = $row['contents'];
    }

    // Tạo một mảng dữ liệu PHP
    $data = array();
    for ($i = 0; $i < count($questionsid); $i++) {
        // Câu truy vấn SQL
        $query = "SELECT contents FROM answer WHERE id_question = ?";
        $params = array($questionsid[$i]);

        // Thực thi truy vấn
        $result = sqlsrv_query($conn, $query, $params);

        if ($result === false) {
            die(print_r(sqlsrv_errors(), true));
        }

        // Mảng để lưu trữ kết quả
        $answers = array();

        // Lặp qua từng dòng kết quả và lưu vào mảng
        while ($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
            $answers[] = $row['contents'];
        }

        $data[] = array(
            'id_question' => $questionsid[$i],
            'question' => $questions_content[$i],
            'answers' => $answers,
            'type' => 1
        );
    }

    // Chuyển đổi dữ liệu thành chuỗi JSON
    $jsonString = json_encode($data);
    // In ra chuỗi JSON
    echo $jsonString;

    sqlsrv_close($conn);
}
?>