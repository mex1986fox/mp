<?php
namespace App\Controllers;

use \App\Models\Api\Captcha\Show as CapthaShow;

class CaptchaController extends MainController
{

    public function show($request, $response, $args)
    {
        $reg = new CapthaShow();
        $answer = $reg->run();
        $response = $response->withHeader('Content-type', "image/png");
        imagepng($answer);
        imagedestroy($answer);
        return $response;
    }
    public function create($request, $response, $args)
    {
        return $response;

    }
    public function update($request, $response, $args)
    {
        return $response;
    }
    public function delete($request, $response, $args)
    {
        return $response;
    }
}
