<?php

class Magasin{

    protected $nomMagasin; 
    protected $adresse ; 
    protected $cp;
    protected $ville;
    protected $modeDeRestauration;

    public function __construct($nomMagasin,$adresse,$cp,$ville,$modeDeRestauration)
    {
        $this->nomMagasin = $nomMagasin;
        $this->adresse = $adresse;
        $this->cp = $cp;
        $this->ville=$ville;
        $this->modeDeRestauration = $modeDeRestauration;
    }

    public function getNomMagasin(){
        return $this->nomMagasin;
    }
    public function setNomMagasin($nomMagasin) {
        $this->nomMagasin = $nomMagasin;
    }

    public function getAdresse(){
        return $this->adresse;
    }
    public function setAdresse($adresse) {
        $this->adresse = $adresse;
    }

    public function getCp(){
        return $this->cp;
    }
    public function setCp($cp) {
        $this->cp = $cp;
    }

    public function getVille(){
        return $this->ville;
    }
    public function setVille($ville) {
        $this->ville = $ville;
    }

    public function getModeDeRestauration(){
        return $this->modeDeRestauration;
    }
    public function setModeDeRestauration($modeDeRestauration) {
        $this->modeDeRestauration = $modeDeRestauration;
    }

    public function affilierMagasin(){
        $magName = $this->getNomMagasin();

        if($magName = 'WayneCorp' OR $magName="StarLab" ){
            $this->setModeDeRestauration('Restaurant');

            if ($magName = 'WayneCorp' ) {
                $this->setCp('66666');
                $this->setAdresse('6 Rue de la Cave');
                $this->setVille('Gotham City');

            } else if ($magName = 'StarLab') {
                $this->setCp('65845');
                $this->setAdresse('Rue Harrisson Wells');
                $this->setVille('StarCity');
            }
        } else {
            $this->setModeDeRestauration('Tickets');

            if ($magName = 'Krypton&Co'){
                $this->setCp('12123');
                $this->setAdresse('Impasse John Kent');
                $this->setVille('Smallville');
            }else if($magName = 'Gardiens Compagnie'){
                $this->setCp('02456');
                $this->setAdresse('Avenue Jean Chopin');
                $this->setVille('Space port');
            }

        }
    }
}