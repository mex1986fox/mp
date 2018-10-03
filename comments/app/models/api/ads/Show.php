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
            $adID = $p["ad_id"];
            if (!empty($p["comment_id"])) {
                $commentID = $p["comment_id"];
            }
            $mdb = $this->container['mongodb'];
            if (empty($commentID)) {
                $commentsID = $mdb->ads->findOne(["_id" => $adID])["comments_id"];
            }else{
                $commentsID = $mdb->ads->findOne(["_id" => $adID, "comments.id" => $commentID])["comments_id"];
            }
            $ads = $mdb->ads->findOne(["_id" => 8, "comments.id" => ['$in' => [1]]]);

            return ["comments" => $ads["comments"]];
        } catch (RuntimeException | \Exception $e) {
            $exceptions = ['exceptions' => ['massege' => $e->getMessage()]];
            return $exceptions;
        }
    }
}
