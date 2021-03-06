<?php
namespace App\Services\Auth;

class AuthAdd
{
    protected $container;
    public function __construct($container)
    {
        $this->container = $container;
    }
    public function Authed($user_id, $add_id)
    {
        $authHost = $this->container["hosts"]["auth"];
        $jsonDatas = array(
            'add_id' => $add_id,
        );
        $jsonDataEncoded = json_encode($jsonDatas);
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $authHost . "/api/show/ads");
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json'));
        curl_setopt($ch, CURLOPT_POSTFIELDS, $jsonDataEncoded);
        // curl_setopt($ch, CURLOPT_COOKIE, "PHPSESSID=$session");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        $output = curl_exec($ch);
        $rCode = curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
        curl_close($ch);
        $dj = json_decode($output);
        if ($rCode == 200 && !isset($dj->exceptions)) {
            if (count($dj->ads) != 0 && $dj->ads[0]->user_id == $user_id) {
                return true;
            }
        };
        return false;

    }
}
