'use strict';

/* Controllers */

angular.module('7minWorkout')
  .controller('WorkoutController', ['$scope', '$interval', function ($scope, $interval) {
      function WorkoutPlan(args) {
          this.exercises = [];
          this.name = args.name;
          this.title = args.title;
          this.restBetweenExercise = args.restBetweenExercise;
      };

      function Exercise(args) {
          this.name = args.name;
          this.title = args.title;
          this.description = args.description;
          this.image = args.image;
          this.related = {};
          this.related.videos = args.videos;
          this.nameSound = args.nameSound;
          this.procedure = args.procedure;
      }

      var restExercise;
      var workoutPlan;
      var startWorkout = function () {
          workoutPlan = createWorkout();
          restExercise = {
              details: new Exercise({
                  name: "rest",
                  title: "Relax!",
                  description: "Relax a bit!",
                  image: "img/rest.png",
              }),
              duration: workoutPlan.restBetweenExercise
          };
          startExercise(workoutPlan.exercises.shift());
      };


      var startExercise = function (exercisePlan) {
          $scope.currentExercise = exercisePlan;
          $scope.currentExerciseDuration = 0;
          $interval(function () {
              $scope.currentExerciseDuration = $scope.currentExerciseDuration + 1;
          }, 1000, $scope.currentExercise.duration);
      };

      var createWorkout = function () {
          var workout = new WorkoutPlan({
              name: "7minWorkout",
              title: "7 Minute Workout",
              restBetweenExercise: 10
          });

          workout.exercises.push({
              details: new Exercise({
                  name: "pushUp",
                  title: "Push Up",
                  description: "A push-up is a common exercise performed in a prone position by raising and lowering the body using the arms",
                  image: "img/Pushup.png",
                  videos: ["//www.youtube.com/embed/Eh00_rniF8E", "//www.youtube.com/embed/ZWdBqFLNljc", "//www.youtube.com/embed/UwRLWMcOdwI", "//www.youtube.com/embed/ynPwl6qyUNM", "//www.youtube.com/embed/OicNTT2xzMI"],
                  procedure: "Lie prone on the ground with hands placed as wide or slightly wider than shoulder width. \
                              Keeping the body straight, lower body to the ground by bending arms at the elbows. \
                              Raise body up off the ground by extending the arms."
              }),
              duration: 30
          });
          return workout;
      }

      var init = function () {
          startWorkout();
      };

      init();
  }]);