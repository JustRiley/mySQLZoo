(function () {
    angular
        .module("zoo")
        .controller("homeController", homeController);

    function homeController($routeParams, testService, $location, $route, $http) {
        var model = this;
        model.postQuery = postQuery;
        model.queryType ="exhibit";


        function postQuery() {
            var testObj = {type: model.queryType};
            $http.post('/get_data', testObj)
                .then(function (success){
                    model.data_server=success['data'];
            },function (error){
                alert("Connection Error");
            });
        }

        function init() {
            postQuery();
        }
        init();

    }
})();