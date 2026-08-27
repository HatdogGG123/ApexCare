<?php
include_once("Db.php");

class Delivery
{
    private $pdo;

    public function __construct()
    {
        $db = new Db();
        $this->pdo = $db->connect();
    }
}
