<?php

require_once("Db.php");

class Delivery extends Db

{
    // ================================================================
    // FUNCTIONS TO FETCH DATA
    // ================================================================
    public function getAllDeliveryRecord()
    {
        $sql = "SELECT d.delivery_number, FORMAT(d.total_amount, 2) AS total_cost, DATE_FORMAT(d.received_date, '%M, %e, %Y') as received_date, s.name AS supplier_name FROM delivery_table d 
                JOIN supplier_table s ON d.supplier_id = s.supplier_id;";

        return $this->getResult($sql);
    }

    public function getFilteredDeliveryRecord($receiver_id, $supplier_name_filter, $from_date_filter, $to_date_filter, $search_query)
    {

        $sql = "SELECT 
                    d.delivery_id, 
                    CONCAT(u.first_name, ' ', COALESCE(u.middle_name, ''), ' ', u.last_name) AS receiver_name, 
                    d.delivery_number, 
                    FORMAT(d.total_amount, 2) AS total_cost, 
                    DATE_FORMAT(d.received_date, '%M %e, %Y') as received_date, 
                    s.name AS supplier_name 
                FROM delivery_table d 
                JOIN user_table u ON d.receiver_id = u.user_id
                JOIN supplier_table s ON d.supplier_id = s.supplier_id
                WHERE d.receiver_id = ?";
        $params = [$receiver_id];

        if (!empty($search_query)) {
            $sql .= "AND delivery_number LIKE ?";
            $params[] = "%" . trim($search_query) . "%";
        }

        if (!empty($supplier_name_filter)) {
            $sql .= "AND s.name = ?";
            $params[] = $supplier_name_filter;
        }

        if (!empty($from_date_filter) && !empty($to_date_filter)) {
            $sql .= "AND d.received_date BETWEEN ? AND ?;";
            $params[] = $from_date_filter . " 00:00:00";
            $params[] = $to_date_filter . " 23:59:59";
        }

        // $stmt = $this->connect()->prepare($sql);
        // $stmt->execute($params);

        return $this->getResult($sql, $params);
    }

    public function getDeliveryRecordById($delivery_id)
    {
        $sql = "SELECT 
                    d.delivery_id, 
                    CONCAT(u.first_name, ' ', u.middle_name, ' ', u.last_name) AS receiver_name, 
                    d.delivery_number, 
                    FORMAT(d.total_amount, 2) AS total_cost, 
                    DATE_FORMAT(d.received_date, '%M, %e, %Y') as received_date, 
                    s.name AS supplier_name 
                FROM delivery_table d 
                JOIN user_table u ON d.receiver_id = u.user_id
                JOIN supplier_table s ON d.supplier_id = s.supplier_id
                WHERE d.delivery_id = ?
                ORDER BY d.received_date ASC;";

        $stmt = $this->connect()->prepare($sql);
        $stmt->execute([
            $delivery_id
        ]);

        return $stmt->fetch();
    }

    public function getDeliveryDetail($delivery_id)
    {
        $sql = "SELECT 
                    d.delivery_detail_id,
                    m.name AS medicine_name, 
                    d.batch_number, 
                    FORMAT(d.unit_price, 2) AS unit_price,
                    d.received_quantity, 
                    o.request_quantity,
                    FORMAT((d.unit_price * d.received_quantity), 2) AS sub_total_amount
                FROM delivery_detail_table d 
                JOIN medicine_table m ON d.medicine_id = m.medicine_id
                JOIN order_detail_table o ON d.order_detail_id = o.order_detail_id
                WHERE delivery_id = ?;";

        $stmt = $this->connect()->prepare($sql);
        $stmt->execute([
            $delivery_id
        ]);

        return $stmt->fetchAll();
    }

    public function getDeliveryGrandTotalAmount($delivery_id)
    {
        $sql = "SELECT 
                    FORMAT(sum((unit_price * received_quantity)), 2) AS total_amount 
                FROM delivery_detail_table 
                WHERE delivery_id = ?;";

        $stmt = $this->connect()->prepare($sql);
        $stmt->execute([
            $delivery_id
        ]);

        return $stmt->fetch();
    }

    public function getDeliveryDetailCount($delivery_id)
    {
        $sql = "SELECT COUNT(delivery_id) AS received_items_count FROm delivery_detail_table WHERE delivery_id = ?";

        $stmt = $this->connect()->prepare($sql);
        $stmt->execute([
            $delivery_id
        ]);

        return $stmt->fetch();
    }

    public function getDeliveryCount()
    {
        $sql = "SELECT COUNT(*) AS totalDeliveryCount FROM delivery_table";

        $stmt = $this->connect()->prepare($sql);
        $stmt->execute();

        return $stmt->fetchAll();
    }

    public function createDelivery($supplier_id, $receiver_id, $total_amount)
    {
        $sql = "INSERT INTO delivery_table (supplier_id, receiver_id, total_amount) VALUES (?, ?, ?)";

        $stmt = $this->connect()->prepare($sql);

        $stmt->execute([
            $supplier_id,
            $receiver_id,
            $total_amount,
        ]);


        return $stmt->rowCount();
    }

    // ================================================================
    // FUNCTIONS TO INSERT DATA
    // ================================================================

    // ================================================================
    // FUNCTIONS TO UPDATE DATA
    // ================================================================

    // ================================================================
    // HELPER FUNCTIONS
    // ================================================================

    // Function to catch the error if there are any error when
    // connecting to database (Fetching, Inserting, Deleting, or 
    // Updating Records)
    // 
    // $query - SQL Query to be performed
    // $executeParameters (Optional Parameter) - The parameters needed to execute the prepared statements
    //                    - This is the values needed to match the number of placeholders ('?' symbol)
    // 
    // Can be called as:
    //  - getResult($sql);
    //  - getResult($sql, $executeParameters);
    public function getResult($query, $executeParameters = [])
    {
        try {
            $stmt = $this->connect()->prepare($query);
            $stmt->execute($executeParameters);

            return $stmt->fetchAll();
        } catch (\Throwable $e) {
            return ['status' => 'error', 'message' => $e->getMessage()];
        }
    }
}
