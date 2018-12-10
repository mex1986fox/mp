<?php
namespace App\Models\Api\Ads;

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
                $commentsID = $mdb->ads->findOne(["_id" => $ID])["comments_id"];
            } else {
                $aggreg = iterator_to_array($mdb->ads->aggregate([
                    ['$match' => ['_id' => $ID]],
                    ['$unwind' => '$comments'],
                    ['$match' => ['comments.id' => $commentID]],
                ]), false);
                $commentsID = $aggreg[0]['comments']['comments_id'];
            }
            // var_dump($commentsID);
            if(empty($commentsID)){
                throw new \Exception("Нет коментариев к данному объявлению");
            }
            
            $aggreg = $mdb->ads->aggregate([
                ['$match' => ['_id' => $ID]],
                ['$unwind' => '$comments'],
                ['$match' => ['comments.id' => ['$in' => $commentsID]]],
            ]);
           
            $ads = array_map(function ($ad) {
                return $ad["comments"];
            }, iterator_to_array($aggreg, false));
              // $ads = $mdb->ads->findOne(["_id" => 8, "comments.id" => ['$in' => [1]]]);

            return ["comments" => $ads];
        } catch (RuntimeException | \Exception $e) {
            $exceptions = ['exceptions' => ['massege' => $e->getMessage()]];
            return $exceptions;
        }
    }
}
