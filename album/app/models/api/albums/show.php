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
            if (!empty($p["id"])) {
                $id = $p["id"];
            }
            //формируем условия выборки
            $qWhere = "";
            // для номера альбома
            $qWhere = $qWhere . (empty($id) ? "" : "id=" . $id . " and ");

            //для местоположения
            if (!empty($p["settlements"]) || !empty($p["subjects"]) || !empty($p["countries"])) {
                $qWhere = $qWhere . " (";
            }
            //  для страны
            $qWhere = $qWhere . (empty($p["countries"]) ? "" : "countries_id in (" . implode(', ', $p["countries"]) . ") or ");
            //  для региона
            $qWhere = $qWhere . (empty($p["subjects"]) ? "" : "subjects_id in (" . implode(', ', $p["subjects"]) . ") or ");
            //  для города
            $qWhere = $qWhere . (empty($p["settlements"]) ? "" : "settlements_id in (" . implode(', ', $p["settlements"]) . ") or ");
            if (!empty($p["settlements"]) || !empty($p["subjects"]) || !empty($p["countries"])) {
                $qWhere = rtrim($qWhere, ' or ') . ") and ";
            }

            //  для тарнспорта
            if (!empty($p["transports"]) || !empty($p["brands"]) || !empty($p["models"])) {
                $qWhere = $qWhere . " (";
            }
            //  для вида тарнспорта
            $qWhere = $qWhere . (empty($p["transports"]) ? "" : "transport_id in (" . implode(', ', $p["transports"]) . ") or ");
            //  для бренда
            $qWhere = $qWhere . (empty($p["brands"]) ? "" : "brand_id in (" . implode(', ', $p["brands"]) . ") or ");
            //  для моделей
            $qWhere = $qWhere . (empty($p["models"]) ? "" : "model_id in (" . implode(', ', $p["models"]) . ") or ");
            if (!empty($p["transports"]) || !empty($p["brands"]) || !empty($p["models"])) {
                $qWhere = rtrim($qWhere, ' or ') . ") and ";
            }

            //для года
            $qWhere = $qWhere . (empty($p["year"]) ? "" : "year::numeric>=" . $p["year"] . " and ");
            $qWhere = $qWhere . (empty($p["yearBef"]) ? "" : "year::numeric<=" . $p["yearBef"] . " and ");

            $qWhere = empty($qWhere) ? "" : rtrim($qWhere, ' or ');
            $qWhere = empty($qWhere) ? "" : rtrim($qWhere, ' and ');
            $qWhere = (empty($qWhere) ? "" : "where ") . $qWhere;

            //формируем условия сортировки
            $qSort = "";
            if (!empty($p["sort"])) {
                $sort = implode("", $p["sort"]);
                // дате (новые)
                $qSort = $qSort . ($sort == '1' ? "date_create DESC, " : "");
                // дате (старые)
                $qSort = $qSort . ($sort == '2' ? "date_create ASC, " : "");
                // году (новые)
                $qSort = $qSort . ($sort == '3' ? "year DESC, " : "");
                // оду (старые)
                $qSort = $qSort . ($sort == '4' ? "year ASC, " : "");

            } else {
                // по умолчанию
                // дате (новые)
                $qSort = $qSort . "date_create DESC, ";
            }
            $qSort = empty($qSort) ? "" : rtrim($qSort, ', ');
            $qSort = (empty($qSort) ? "" : " ORDER BY ") . $qSort;

            $db = $this->container['db'];
            $q = "select * from albums " . $qWhere . $qSort;
            $ads = $db->query($q, \PDO::FETCH_ASSOC)->fetchAll();
            return ["albums" => $ads];
        } catch (RuntimeException | \Exception $e) {
            $exceptions = ['exceptions' => ['massege' => $e->getMessage()]];
            return $exceptions;
        }
    }
}
