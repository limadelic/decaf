exports.Calculator = (function() {

    function Calculator() {}

    Calculator.prototype.square = function(x) {
        return x * x;
    };

    return Calculator;

})();