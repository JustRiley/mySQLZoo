(function () {
    angular
        .module("zoo")
        .controller("homeController", homeController);

    function homeController($routeParams, testService, $location, $route, $http) {
        var model = this;
        model.postQuery = postQuery;
        model.addEmployee = addEmployee;
        model.delEmployee = delEmployee;
        model.resetMessages = resetMessages;
        model.queryType ="";
        model.delEmployeeName ="";
        model.employeeName ="";
        model.employeeSalary = 0;
        model.employeeRole = "";
        model.successMessageEmployee = false;
        model.successMessageDelEmployee = false;



        function resetMessages() {
            model.successMessageDelEmployee = false;
            model.successMessageEmployee = false;
        }

        function delEmployee() {
            var postObj = {name: model.delEmployeeName};
            $http.post('/delEmployee', postObj)
                .then(function (success){
                    model.successMessageDelEmployee=success;
                },function (error){
                    alert("Connection Error");
                });
        }

        function addEmployee() {
            var postObj = {
                name: model.employeeName,
                salary: model.employeeSalary,
                role: model.employeeRole};
            $http.post('/addEmployee', postObj)
                .then(function (success){
                    model.successMessageEmployee=success;
                },function (error){
                    alert("Connection Error");
                });
        }


        function postQuery() {
            var postObj = {type: model.queryType};
            $http.post('/get_data', postObj)
                .then(function (success){
                    model.data_server=success['data'];
            },function (error){
                alert("Connection Error");
            });
        }

        function init() {
            resetMessages();
        }
        init();

    }
})();