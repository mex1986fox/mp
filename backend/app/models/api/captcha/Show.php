<?php
namespace App\Models\Api\Captcha;

class Show
{

    public function run()
    {
        try {
            $answer = "";
            // создаем  загадку
            for ($i = 0; $i < rand(5, 7); $i++) {
                if (rand(0, 1) == 1) {
                    $answer = $answer . chr(rand(49, 57));
                } else {
                    $answer = $answer . chr(rand(97, 122));
                }
            }
            // шифруем и помещаем загадку в сессию
            $_SESSION['captcha'] = md5($answer);

            // создаем фон картинки
            $image = imagecreatetruecolor(200, 80);
            //Отключаем режим сопряжения цветов
            imagealphablending($image, false);
            imagefill($image, 0, 0, imagecolorallocatealpha($image, 0, 0, 0, 127));
            //Включаем сохранение альфа канала
            imagesavealpha($image, true);
            $y = 0;
            for ($i = 0; $i < strlen($answer); $i++) {
                //наклон формируем
                if (rand(0, 1) == 1) {
                    $angle = rand(0, 25);
                } else {
                    $angle = rand(335, 360);
                }
                $y = $y + rand(18, 22);
                $x = rand(45, 65);
                $color = imagecolorallocate($image, rand(0, 255), rand(0, 255), rand(0, 255));
                imagettftext($image, 35, $angle, $y, $x, $color, __dir__ . "/verdana.ttf", $answer[$i]);
            }
            // header("Content-type: image/png");
            // imagepng($image);
            // imagedestroy($image);
            return $image;

        } catch (\Exception $e) {
            return $exceptions;
        }

    }
}
