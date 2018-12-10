<?php
namespace App\Models\Api\Albums;

use \Zend\Validator\Exception\RuntimeException as RuntimeException;

class Show
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
            $p = $this->request->getQueryParams();
            $ID = (int) $p["id"];
            if (!empty($p["comment_id"])) {
                $commentID = (int) $p["comment_id"];
            }
            $mdb = $this->container['mongodb'];
            // db.ads.find({'_id': 8, "comments":{$elemMatch: { "id" : 1 }}},{"comments.id":1, "comments":{$elemMatch: { "id" : 1 }}})
            if (empty($commentID)) {
                $commentsID = $mdb->albums->findOne(["_id" => $ID])["comments_id"];
            } else {
                $aggreg = iterator_to_array($mdb->albums->aggregate([
                    ['$match' => ['_id' => $ID]],
                    ['$unwind' => '$comments'],
                    ['$match' => ['comments.id' => $commentID]],
                ]), false);
                $commentsID = $aggreg[0]['comments']['comments_id'];
            }
            // var_dump($commentsID);
            if (empty($commentsID)) {
                throw new \Exception("Нет коментариев к данному объявлению");
            }

            if (!empty($p['pagin_id'])) {
                // если указана пагинация
                // развернуть

                $revComsID = array_reverse(iterator_to_array($commentsID, false));
                // подсчитать длинну
                $paginLen = array_search($p['pagin_id'], $revComsID);

                $aggreg = $mdb->albums->aggregate([
                    ['$match' => ['_id' => $ID]],
                    ['$unwind' => '$comments'],
                    ['$match' => ['comments.id' => ['$in' => $commentsID]]],
                    ['$sort' => ['comments.date_create' => -1]],
                    ['$skip' => $paginLen + 1],
                    ['$limit' => 2],
                ]);
            } else {
                // без пагинации
                $aggreg = $mdb->albums->aggregate([
                    ['$match' => ['_id' => $ID]],
                    ['$unwind' => '$comments'],
                    ['$match' => ['comments.id' => ['$in' => $commentsID]]],
                    ['$sort' => ['comments.date_create' => -1]],
                    ['$limit' => 2],
                ]);
            }

            $albums = array_map(function ($album) {
                return $album["comments"];
            }, iterator_to_array($aggreg, false));
            // $albums = $mdb->albums->findOne(["_id" => 8, "comments.id" => ['$in' => [1]]]);

            return ["comments" => $albums];
        } catch (RuntimeException | \Exception $e) {
            $exceptions = ['exceptions' => ['massege' => $e->getMessage()]];
            return $exceptions;
        }
    }
}
