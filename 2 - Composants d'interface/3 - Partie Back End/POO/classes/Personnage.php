<?php 

class Personnage {
    private string $nom;
    private string $prenom;
    private int $age;
    private string $sexe;

    public function __construct ($nom='',$prenom='',$age=0,$sexe='F'){
        $this -> nom = $nom; 
        $this -> prenom = $prenom; 
        $this -> age = $age; 
        $this -> sexe = $sexe; 
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

    public function getAge(){
        return $this->age;
    }
    public function setAge($age) {
        $this->age = $age;
    }

    public function detSexe(){
        return $this->sexe;
    }
    public function setSexe($sexe) {
        $this->sexe = $sexe;
    }

    
}
$p = new Personnage();
$p->setNom("Wayne");
$p->setPrenom("Bruce");

var_dump($p);