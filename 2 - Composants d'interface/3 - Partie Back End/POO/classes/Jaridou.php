<?php
include 'Employe.php';

$today = date("m.d.y");  

$e = new Employe('Wayne','Bruce',"05-01-2012",60000,'DRH');
$e->setNomMagasin('WayneCorp');
$e->affilierMagasin();

$e2 = new Employe('Kent','Clark',"12-08-2020",30000,'Comptabilitée');
$e2->setNomMagasin('Krypton&Co');
$e2->affilierMagasin();

$e3 = new Employe('Prince','Diana',"08-06-2015",45000,'Conservation');
$e3->setNomMagasin('WayneCorp');
$e3->affilierMagasin();

$e4 = new Employe('Allen','Barry',"24-02-2013",30500,'Facturation');
$e4->setNomMagasin('StarLab');
$e4->affilierMagasin();

$e5 = new Employe('Jordan','Hal',"12-12-2024",40000,'Securite');
$e5->setNomMagasin('Gardiens Compagnie');
$e5->affilierMagasin();


$e->tempsEmploye($e->getEmbauche());
$e2->tempsEmploye($e2->getEmbauche());



$today = date("m.d");  
//$today = "11.30";

if ($today == "11.30")
{
    echo ("Pour ". $e->getNom() ." ". $e->getPrenom() . " : " . $e->declancherPrime($e));
    echo  ("Pour ". $e2->getNom() ." ". $e2->getPrenom() . " : " . $e2->declancherPrime($e2));
    echo  ("Pour ". $e3->getNom() ." ". $e3->getPrenom() . " : " . $e3->declancherPrime($e3));
    echo  ("Pour ". $e4->getNom() ." ". $e4->getPrenom() . " : " . $e4->declancherPrime($e4));
    echo  ("Pour ". $e5->getNom() ." ". $e5->getPrenom() . " : " . $e5->declancherPrime($e5));

} else {
   
    echo ("");
}


echo ("Pour ". $e->getNom() ." ". $e->getPrenom() . " Travaillant dans le magasin :  " .$e->getNomMagasin(). " situé à " . $e->getVille() . ", le moyen de restauration est :  " . $e->getModeDeRestauration() ."\r\n" );
echo ("Pour ". $e2->getNom() ." ". $e2->getPrenom() . " Travaillant dans le magasin :  " .$e2->getNomMagasin(). " situé à " . $e2->getVille() . ", le moyen de restauration est :  " . $e2->getModeDeRestauration() ."\r\n" );
echo ("Pour ". $e3->getNom() ." ". $e3->getPrenom() . " Travaillant dans le magasin :  " .$e3->getNomMagasin(). " situé à " . $e3->getVille() . ", le moyen de restauration est :  " . $e3->getModeDeRestauration() ."\r\n" );
echo ("Pour ". $e4->getNom() ." ". $e4->getPrenom() . " Travaillant dans le magasin :  " .$e4->getNomMagasin(). " situé à " . $e4->getVille() . ", le moyen de restauration est :  " . $e4->getModeDeRestauration() ."\r\n" );
echo ("Pour ". $e5->getNom() ." ". $e5->getPrenom() . " Travaillant dans le magasin :  " .$e5->getNomMagasin(). " situé à " . $e5->getVille() . ", le moyen de restauration est :  " . $e5->getModeDeRestauration() ."\r\n" );

echo ($e->chequeVacances());
echo ($e5->chequeVacances());


$e->avoirEnfants($e->getNom(),'Dick',19);
$e->avoirEnfants($e->getNom(),'Jason',15);
$e->avoirEnfants($e->getNom(),'Tim',11);
$e->avoirEnfants($e->getNom(),'Damian',5);

$e4->avoirEnfants($e4->getNom(),'Don',8);
$e4->avoirEnfants($e4->getNom(),'Dawn',8);

$e2->avoirEnfants($e2->getNom(),'Joel',15);
$e2->avoirEnfants($e2->getNom(),'Kara',12);

var_dump ($e->getChildren()[0]['nom']);

var_dump($e3->childExists());
var_dump($e->childExists());

var_dump($e->chequesNoel());
var_dump($e4->chequesNoel());
var_dump($e2->chequesNoel());
var_dump($e3->chequesNoel());
