<?
$state = $_GET['state'] ;
if ($state=='creat') {
        $session_name = $_GET['session_name'] ;
        $user_name = $_GET['user_name'] ;
        $myfile = fopen("$session_name.txt", "w+") or die("Unable to open file!");

        fclose($myfile);
        $myfile = fopen($session_name.'_chat.txt', "w+") or die("Unable to open file!");
        $txt = "$user_name#\n";
        fwrite($myfile, $txt);
        fclose($myfile);
        echo 'b';
}elseif
 ($state=='join') {
        $session_name = $_GET['session_name'] ;
        $user_name = $_GET['user_name'] ;
        if (file_exists("$session_name.txt"))
        {
                $input = file_get_contents($session_name.'_chat.txt'); 
                $str = strtok($input, "\n");
                $str=$str.$user_name;
                $myfile = fopen($session_name.'_chat.txt', "w+") or die("Unable to open file!");
                //$txt = "$user_name#\n";
                fwrite($myfile, "$str");
                fclose($myfile);

        echo 'a';       
        }
}
elseif
($state=='play') {
       $session_name = $_GET['session_name'] ;
       $user = $_GET['user'] ;
       $move = $_GET['move'] ;
       
        $myfile = fopen("$session_name.txt", "a") or die("Unable to open file!");
        $txt = "$user:$move\n";
        fwrite($myfile, $txt);
        fclose($myfile);
       

}
elseif 
($state=='info1') {                                 //step 1 move
       $session_name = $_GET['session_name'] ;
       $user = $_GET['user'] ;

        if ($user =='a') 
        { $getuser='b'; } 
        else 
        { $getuser='a'; }

        $file = file("$session_name.txt");

        for ($i = max(0, count($file)-2); $i < count($file); $i++) {
          //echo "1".$file[$i];
          $txt = explode(":", $file[$i]);
         if ($txt[0]==$getuser.'1') {   echo $txt[1]; exit; } 
        }
        echo "notyet";
}
elseif
($state=='info2') {                                 //step 1 move
        $session_name = $_GET['session_name'] ;
        $user = $_GET['user'] ;
 
         if ($user =='a') 
         { $getuser='b'; } 
         else 
         { $getuser='a'; }
 
         $file = file("$session_name.txt");
 
         for ($i = max(0, count($file)-2); $i < count($file); $i++) {
           //echo "1".$file[$i];
           $txt = explode(":", $file[$i]);
          if ($txt[0]==$getuser.'2') {   echo $txt[1]; exit; } 
         }
         echo "notyet";
 }

 elseif
 ($state=='chat') {                                 //step 1 move
         $session_name = $_POST['session_name'] ;
         $user = $_POST['user'] ;
         $user_name= $_POST['user_name'] ;
         $msg=$_POST['msg'] ;
         $myfile = fopen($session_name.'_chat.txt', "a") or die("Unable to open file!");
         $txt = "$user_name : $msg\n";
         fwrite($myfile, $txt);
         fclose($myfile);
          
  } 
  elseif
  ($state=='getchat') {                                 //step 1 move
          $session_name = $_GET['session_name'] ;
          $user = $_GET['user'] ;
          $user_name=$_GET['user_name'] ;
          //$myfile = fopen($session_name.'_chat.txt', "a") or die("Unable to open file!");
          //$txt = "$user_name : $msg\n";
          //fwrite($myfile, $txt);
          //fclose($myfile);
          $file = file_get_contents($session_name.'_chat.txt'); 
          echo $file;
   } 

?>