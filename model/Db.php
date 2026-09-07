<?php
class Db
{
    private $serverName = "localhost";
    private $userName = "root";
    private $password = "@Password123";
    private $dbName = "pharmacy_db";

    private $pdo;

    public function __construct()
    {
        $dsn = 'mysql:host=' . $this->serverName . ';dbname=' . $this->dbName . ';';
        $this->pdo = new PDO($dsn, $this->userName, $this->password);
        $this->pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    }

    // Method to get the connection object
    public function connect()
    {
        return $this->pdo;
    }
}
