<?


function getDB()
{

  $host = "127.0.0.1";
  $user = "user database";
  $pass = "your pass";
  $db_name = "name database";

    try 
    {
      $db = new PDO("mysql:host=$host;dbname=$db_name", $user, $pass); 
      $db->exec("set names utf8");
      $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
      return $db ;
    }
      catch(PDOException $err)
    {
     die('Connection failed: ' . $err->getMessage());
    }
} 


  ?>