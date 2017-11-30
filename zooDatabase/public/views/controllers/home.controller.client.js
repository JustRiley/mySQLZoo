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
        model.addAnimal = addAnimal;
        model.delAnimal = delAnimal;
        model.updateEmployee = updateEmployee;
        model.queryType ="";
        model.delEmployeeName ="";
        model.employeeName ="";
        model.employeeSalary = 0;
        model.employeeRole = "";
        model.successMessageEmployee = false;
        model.successMessageDelEmployee = false;
        model.successMessageAnimal = false;
        model.successMessageDelAnimal = false;
        model.successMessageUpdateEmployee = false;
        model.animalName="";
        model.speciesKey=0;
        model.medicalHistKey=0;
        model.animalPerform=false;
        model.exhibitKey=0;
        model.delAnimalName="";



        function updateEmployee() {
            var postObj = {
                name: model.employeeName,
                salary: model.employeeSalary,
                role: model.employeeRole};
            $http.post('/updateEmployee', postObj)
                .then(function (success){
                    model.successMessageUpdateEmployee=success;
                },function (error){
                    alert("Connection Error");
                });
        }

        function resetMessages() {
            model.successMessageDelEmployee = false;
            model.successMessageEmployee = false;
            model.successMessageAnimal = false;
            model.successMessageDelAnimal = false;
            model.successMessageUpdateEmployee = false;
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

        function addAnimal() {
            var postObj = {
                name: model.animalName,
                speciesKey: model.speciesKey,
                medicalHistKey: model.medicalHistKey,
                animalPerforms: model.animalPerform,
                exhibitKey: model.exhibitKey};
            $http.post('/addAnimal', postObj)
                .then(function (success){
                    model.successMessageAnimal=success;
                },function (error){
                    alert("Connection Error");
                });
        }

        function delAnimal() {
            var postObj = {name: model.delAnimalName};
            $http.post('/delAnimal', postObj)
                .then(function (success){
                    model.successMessageDelAnimal=success;
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