<?

include("config/connect.php");
$db=getDB();

$state = $_GET['state'];


  function select_msg($db,$user,$num,$session){
   // $num=$num+1; 
    $queryy=$db->prepare("SELECT  * FROM msg  WHERE user=:user and num=:num and session=:session  "); 
    $queryy->bindParam(':user', $user);
    $queryy->bindParam(':num', $num);  
    $queryy->bindParam(':session', $session);  

    $queryy->execute();
    return $employees = $queryy->fetchAll();
    $queryy->CloseCursor();
  }

  function _show_($employees){
    foreach($employees as $employee) {
        $msg=$employee['msg'];
        $time=$employee['time'];
        $num=$employee['num'];
        echo "$num~$msg~$time";

    }
    }   

function insert_msg($db,$user,$num,$msg,$session){
    $stmt = $db->prepare("INSERT INTO msg (user,num,msg,session) VALUES (:user,:num,:msg,:session)");
    $stmt->bindParam("user", $user,PDO::PARAM_STR) ;
    $stmt->bindParam("msg", $msg,PDO::PARAM_STR) ;
    $stmt->bindParam("session", $session,PDO::PARAM_STR) ;
    $stmt->bindParam("num", $num,PDO::PARAM_INT) ;
    $stmt->execute();
    //$uid=$db->lastInsertid();
    $db = null;
}



if ($state=='get') {

    $num = $_GET['num'];
    $user = $_GET['user'];
    $session = $_GET['session'];

$employees=select_msg($db,$user,$num,$session);
    _show_($employees);
}

if ($state=='insert') {
   $num = $_GET['num'];
   $user = $_GET['user'];
   $session = $_GET['session'];
    $msg = $_GET['msg'];

    insert_msg($db,$user,$num,$msg,$session);

}



?>