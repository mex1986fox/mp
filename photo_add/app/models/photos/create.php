<?php
namespace App\Models\Api\Photos;

use \Zend\Validator\Exception\RuntimeException as RuntimeException;

class Create
{
    protected $request, $response, $container;
    public function __construct($container, $request, $response)
    {
        $this->request = $request;
        $this->response = $response;
        $this->container = $container;

    }
    public function run()
    {
        try {

            // передаем параметры в переменные
            $p = $this->request->getQueryParams();
            $exceptions = [];

            // проверить авторизацию
            $myCurl = curl_init();
            curl_setopt_array($myCurl, array(
                CURLOPT_URL => 'http://drovito.ru/api/authentication/users',
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_POST => true,
                CURLOPT_POSTFIELDS => http_build_query(array(["user_id"]))//заголовки
            ));
            $response = curl_exec($myCurl);
            curl_close($myCurl);
            
            echo "Ответ на Ваш запрос: ".$response;
            // проверить есть ли такое объявление у пользователя

            // сохранить фотографию 

            // записать в базу ссылку

            $login = $p["login"];
            return ["recovery_key" => $recoveryKey, "massege" => "Регистрация прошла успешно"];
        } catch (RuntimeException | \Exception $e) {
            if($e->getCode()==23505){
                $exceptions["login"] = "Этот логин занят";
            }
            $exceptions['massege'] = $e->getMessage();
            return ["exceptions" => $exceptions];
        }

    }
}
