<?php
include 'Magasin.php';

 class Employe extends Magasin{

    protected string $nom;
    protected string $prenom;
    private $embauche;
    private $salaire;
    protected string $service;
    protected $anneeDeSouffrances;
    protected $prime;
    protected $chqvcs;
    protected array $children;


    public function __construct($nom,$prenom, $embauche,$salaire,$service,$children=[])
    {
        $this -> nom = $nom; 
        $this -> prenom = $prenom; 
        $this -> embauche = $embauche; 
        $this -> salaire = $salaire; 
        $this -> service = $service; 
        $this -> children = $children;
        
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

    public function getChildren(){
        return $this->children;
    }
    public function setChildren($children) {
        $this->children = $children;
    }

    public function tempsEmploye($embauche){
        $now  = date("m-d-y");  
        $rightnow = strtotime($now);
        $backthen = strtotime($embauche);
        $diff = abs($rightnow-$backthen);
        $year = floor($diff/(365*60*60*24));
       $year = intval($year);
        $this->anneeDeSouffrances = $year;
        return $year;
    }

    public function prime ($salaire,$anciennete){
        $anciennete = ( $this->anneeDeSouffrances );
        $salaire = ($this->salaire)*1.05;

        if ($anciennete>0){
            $prime = $salaire + ($anciennete*1.02);
            $this->prime = $prime - $this->getSalaire();
            return $prime;
        }else{
            $this->prime = 0;
            return 0;
        }

    }

    public function declancherPrime($e){
        $montant = $this->prime($this->getSalaire(),$this->tempsEmploye($this->getEmbauche()));
        $mssg = "Déclanchement du paiement de la prime d'un montant de " . $montant ."$  \r\n ";
        return $mssg;
    }

    public function chequeVacances(){
        $ancien = $this->anneeDeSouffrances;
        if ($ancien>=1){
            $rep = "Félicitation " . $this->getPrenom() . " ". $this->getNom() . " vous bénéficiez de cheques vacances ! \r\n";
        } else {
            $rep = "Restez encore un peu avec nous mon vieux ! \r\n";
        }

        return $rep;
    }

    public function avoirEnfants($parent, $nomEnfant,$age){

        
        $enfant = array('Parent' => $parent, "nom" => $nomEnfant, "age" => $age);
        $this->children[] = $enfant;


    }

    public function childExists(){
        $nbrEnfants = sizeof($this->getChildren());

        if ($nbrEnfants>0) {

          $msg = true;
        }else{
            $msg = false;
        }
        return $msg;
    }

    function chequesNoel(){
        $nbrEnfants = sizeof($this->getChildren());
        $isValid = $this->childExists();
        $cqu = 0;

        if ($isValid == false ) {
          $cqu = "Vous n'avez pas d'enfants. \r\n ";
        }
        else{

        for ($i=0; $i < $nbrEnfants ; $i++) { 

            $age = $this->getChildren()[$i]['age'];
            if ($age <= 18 and $age >= 16 ) {
               $cqu = $cqu + 50;
            }
            else if ($age <= 15 and $age >= 11 ) {
                $cqu = $cqu + 30;
            }
            elseif ($age <= 10 and $age >= 0) {
                $cqu = $cqu + 20;
            }
            else{
                $cqu = $cqu + 0 ;
            }
        }   
        $cqu  = "vous allez percevoir : " . $cqu . "$";
    }
        
        return $cqu; 
       
    }

 //   var_dump ($e->getChildren()[0]['nom']);

/*7 - Chaque année, des chèque gérer l'attribution des chèques Noël aux enfants des salariés.

Afficher si l'employé a le droit d'avoir des chèques Noël (Oui/Non). Pour ce faire, établir les conditions nécessaires dans le programme.
gérer l'attribution des chèques Noël aux enfants des salariés.

Afficher si l'employé a le droit d'avoir des chèques Noël (Oui/Non). Pour ce faire, établir les conditions nécessaires dans le programme.

Si la réponse est Oui, afficher combien de chèques de chaque montant sera distribué à l'employé.

Si aucun chèque n'est distribué pour une tranche d'âge, ne pas afficher.


*/


}


