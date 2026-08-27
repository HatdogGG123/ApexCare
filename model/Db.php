<?php
class Db
{
    private $host = "127.0.0.1";
    private $user = "root";
    private $pass = "@Password123"; // Password in your XAMPP or Workbench
    private $dbname = "pharmacy_db";
    private $charset = "utf8mb4";

    private $pdo;
    private $error;

    public function __construct()
    {
        $dsn = "mysql:host={$this->host};dbname={$this->dbname};charset={$this->charset}";

        $options = [
            PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES   => false,
        ];

        try {
            $this->pdo = new PDO($dsn, $this->user, $this->pass, $options);
        } catch (PDOException $e) {
            $this->error = $e->getMessage();
            die("Database Connection Failed: " . $this->error);
        }
    }

    // Method to get the connection object
    public function connect()
    {
        return $this->pdo;
    }
}
