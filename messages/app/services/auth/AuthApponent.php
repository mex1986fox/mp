<?php
namespace App\Services\Auth;

class AuthApponent
{
    protected $container;
    public function __construct($container)
    {
        $this->container = $container;
    }
    public function Authed($user_id)
    {

        $authHost = $this->container["hosts"]["auth"];
        $jsonDatas = array(
            'id' => $user_id,
        );
        $jsonDataEncoded = json_encode($jsonDatas);
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $authHost . "/api/show/users");
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json'));
        curl_setopt($ch, CURLOPT_POSTFIELDS, $jsonDataEncoded);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        $output = curl_exec($ch);
        $rCode = curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
        curl_close($ch);
        $dj = json_decode($output);
        if ($rCode == 200) {
            return true;
        };
        return false;

    }
}
