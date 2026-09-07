<?php

require_once("../model/Delivery.php");

header('Content-Type: application/json');

$delivery = null;

if (empty($_POST["action"])) {
    echo json_encode(['error' => 'Invalid action']);
} else {
    $delivery = new Delivery();

    switch ($_POST["action"]) {
        // ================================================================
        // FUNCTIONS TO FETCH DATA
        // ================================================================
        // Modify to check for errors returned by getResults() inside the Delivery.php
        case 'getAllDeliveryRecords':

            $result = $delivery->getAllDeliveryRecord();

            echo json_encode($result);
            exit();
            break;
        case 'getFilteredDeliveryRecord':
            $result = $delivery->getFilteredDeliveryRecord(
                $_POST["inventory_staff_id"],
                $_POST["supplier_name_filter"],
                $_POST["from_date"],
                $_POST["to_date"],
                $_POST["search_query"]
            );

            echo json_encode($result);
            exit();
            break;
        case 'getDeliveryRecordById':

            $result = [
                "status" => "success",
                "delivery_record_detail" => $delivery->getDeliveryRecordById($_POST["delivery_id"]),
                "delivery_items" => $delivery->getDeliveryDetail($_POST["delivery_id"]),
                "grand_total" => $delivery->getDeliveryGrandTotalAmount($_POST["delivery_id"])
            ];

            echo json_encode($result);
            exit();
            break;
        case 'getDeliveryCount':
            $result = $delivery->getDeliveryCount();

            echo json_encode($result);

            exit();
            break;
        case 'createDelivery':
            if (empty($_POST["supplier_id"]) || empty($_POST["receiver_id"]) || empty($_POST["total_amount"])) {
                echo json_encode(['error' => 'Missing necessary inputs.']);

                exit();
            }

            $result = $delivery->createDelivery($_POST["supplier_id"], $_POST["receiver_id"], $_POST["total_amount"]);

            if (!$result) {
                echo json_encode([
                    "error" => "Error on creating delivery"
                ]);
                exit();
            }

            echo json_encode($result);
            exit();
            break;

        // ================================================================
        // FUNCTIONS TO UPDATE DATA
        // ================================================================

        // ================================================================
        // FUNCTIONS TO DELETE DATA
        // ================================================================

        default:
            echo json_encode(['error' => 'Invalid action']);

            exit();
            break;
    }
}
