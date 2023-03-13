<?php

 class Employe {

    protected string $nom;
    protected string $prenom;
    private  $embauche;
    private string $salaire;
    protected string $service;
    protected $anneeDeSouffrances;


    public function __construct($nom,$prenom, $embauche,$salaire,$service)
    {
        $this -> nom = $nom; 
        $this -> prenom = $prenom; 
        $this -> embauche = $embauche; 
        $this -> salaire = $salaire; 
        $this -> service = $service; 
        
    }

    public function getNom(){
        return $this->nom;
    }
    public function setNom($nom) {
        $this->nom = $nom;
    }

    public function getPrenom(){
        return $this->prenom;
    }
    public function setPrenom($prenom) {
        $this->prenom = $prenom;
    }

    public function getEmbauche(){
        return $this->embauche;
    }
    public function setEmbauche($embauche) {
        $this->embauche = $embauche;
    }

    public function getSalaire(){
        return $this->salaire;
    }
    public function setSalaire($salaire) {
        $this->salaire = $salaire;
    }
    public function getService(){
        return $this->service;
    }
    public function setService($service) {
        $this->service = $service;
    }

    public function tempsEmploye ($embauche){
        $now  = date("m.d.y");  
        $rightnow = strtotime($now);
        $backthen = strtotime($embauche);
        $diff = abs($rightnow-$backthen);

        $year = floor($diff/(365*60*60*24));
        $year = intval($year);
        $this->anneeDeSouffrances = $year;
        return $year;
    }

    public function prime (){
        
    }

}
$today = date("m.d.y");  
$e = new Employe('Wayne','Bruce','03.10.01','55K' ,'DRH');
var_dump($e);
$emb = $e->getEmbauche();
$e->tempsEmploye($e->$emb);

