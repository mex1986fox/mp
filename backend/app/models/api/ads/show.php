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
            if (!empty($p["id"])) {
                $id = $p["id"];
            }
            //формируем условия выборки
            $qWhere = "";
            // для номера объявления
            $qWhere = $qWhere . (empty($id) ? "" : "id=" . $id . " and ");

            //для местоположения
            if (!empty($p["settlements"]) || !empty($p["subjects"]) || !empty($p["countries"])) {
                $qWhere = $qWhere . " (";
            } //  для страны
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

            //для цены
            $qWhere = $qWhere . (empty($p["price"]) ? "" : "price::numeric>=" . str_replace(' ', '', $p["price"]) . " and ");
            $qWhere = $qWhere . (empty($p["priceBef"]) ? "" : "price::numeric<=" . str_replace(' ', '', $p["priceBef"]) . " and ");
            //для года
            $qWhere = $qWhere . (empty($p["year"]) ? "" : "year::numeric>=" . implode('', $p["year"]) . " and ");
            $qWhere = $qWhere . (empty($p["yearBef"]) ? "" : "year::numeric<=" . implode('', $p["yearBef"]) . " and ");
            //для топлива
            $qWhere = $qWhere . (empty($p["fuel"]) ? "" : "fuel_id in (" . implode(', ', $p["fuel"]) . ") and ");
            //для объема
            $qWhere = $qWhere . (empty($p["volume"]) ? "" : "engin_volume::numeric>=" . str_replace(' ', '', $p["volume"]) . " and ");
            $qWhere = $qWhere . (empty($p["volumeBef"]) ? "" : "engin_volume::numeric<=" . str_replace(' ', '', $p["volumeBef"]) . " and ");
            //для кузова
            $qWhere = $qWhere . (empty($p["body"]) ? "" : "body_id in (" . implode(', ', $p["body"]) . ") and ");
            //для привода
            $qWhere = $qWhere . (empty($p["drive"]) ? "" : "drive_id in (" . implode(', ', $p["drive"]) . ") and ");
            //для коробки
            $qWhere = $qWhere . (empty($p["transmission"]) ? "" : "transmission_id in (" . implode(', ', $p["transmission"]) . ") and ");
            //для руля
            $qWhere = $qWhere . (empty($p["wheel"]) ? "" : "wheel in (" . implode(', ', $p["wheel"]) . ") and ");

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
                // цене (дорогие)
                $qSort = $qSort . ($sort == '3' ? "price_corret DESC, " : "");
                // цене (дешевые)
                $qSort = $qSort . ($sort == '4' ? "price_corret ASC, " : "");
                // году (новые)
                $qSort = $qSort . ($sort == '5' ? "year DESC, " : "");
                // оду (старые)
                $qSort = $qSort . ($sort == '6' ? "year ASC, " : "");
                // пробегу (маленький)
                $qSort = $qSort . ($sort == '7' ? "mileage ASC, " : "");
                // пробегу (большой)
                $qSort = $qSort . ($sort == '8' ? "mileage DESC, " : "");
                // объему (маленький)
                $qSort = $qSort . ($sort == '9' ? "engin_volume DESC, " : "");
                // объему (большой)
                $qSort = $qSort . ($sort == '10' ? "engin_volume ASC, " : "");

            } else {
                // по умолчанию
                // дате (новые)
                $qSort = $qSort . ($sort == '1' ? "date_create DESC, " : "");
            }
            $qSort = empty($qSort) ? "" : rtrim($qSort, ', ');
            $qSort = (empty($qSort) ? "" : " ORDER BY ") . $qSort;

            $db = $this->container['db'];
            $q = "select *, price::numeric(10,0) as price_corret from ads " . $qWhere . $qSort;
            $ads = $db->query($q, \PDO::FETCH_ASSOC)->fetchAll();
            return ["ads" => $ads];
        } catch (RuntimeException | \Exception $e) {
            $exceptions = ['exceptions' => ['massege' => $e->getMessage()]];
            return $exceptions;
        }
    }
}
