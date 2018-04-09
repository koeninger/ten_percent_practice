'use strict';

/* Controllers */

angular.module('7minWorkout')
  .controller('WorkoutController', ['$scope', '$interval', '$location', function ($scope, $interval, $location) {
      function WorkoutPlan(args) {
          this.exercises = [];
          this.name = args.name;
          this.title = args.title;
          this.restBetweenExercise = args.restBetweenExercise;
          this.totalWorkoutDuration = function () {
              if (this.exercises.length == 0) return 0;
              var total = 0;
              angular.forEach(this.exercises, function (exercise) {
                  total = total + exercise.duration;
              });
              return this.restBetweenExercise * (this.exercises.length - 1) + total;
          }
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
      var startWorkout = function () {
          $scope.workoutPlan = createWorkout();
          $scope.workoutTimeRemaining = $scope.workoutPlan.totalWorkoutDuration();
          restExercise = {
              details: new Exercise({
                  name: "rest",
                  title: "Relax!",
                  description: "Relax a bit!",
                  image: "img/rest.png",
              }),
              duration: $scope.workoutPlan.restBetweenExercise
          };
          $interval(function () {
              $scope.workoutTimeRemaining = $scope.workoutTimeRemaining - 1;
          }, 1000, $scope.workoutTimeRemaining);

          startExercise($scope.workoutPlan.exercises.shift());
      };

      var startExercise = function (exercisePlan) {
          $scope.currentExercise = exercisePlan;
          $scope.currentExerciseDuration = 0;
          $interval(function () {
              ++$scope.currentExerciseDuration;
          }, 1000, $scope.currentExercise.duration)
          .then(function () {
              var next = getNextExercise(exercisePlan);
              if (next) {
                  startExercise(next);
              }
              else {
                  $location.path('/finish');
              }
          });
      };
      var getNextExercise = function (currentExercisePlan) {
          var nextExercise = null;
          if (currentExercisePlan === restExercise) {
              nextExercise = $scope.workoutPlan.exercises.shift();
          }
          else {
              if ($scope.workoutPlan.exercises.length != 0) {
                  nextExercise = restExercise;
              }
          }
          return nextExercise;
      };

      //$scope.$watch('currentExerciseDuration', function (nVal) {
      //    if (nVal == $scope.currentExercise.duration) {
      //        var next = getNextExercise($scope.currentExercise);
      //        if (next) {
      //            startExercise(next);
      //        } else {
      //            console.log("Workout complete!")
      //        }
      //    }
      //});

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
          workout.exercises.push({
              details: new Exercise({
                  name: "crunches",
                  title: "Abdominal Crunches",
                  description: "The basic crunch is a abdominal exercise in a strength-training program.",
                  image: "img/crunches.png",
                  videos: ["//www.youtube.com/embed/Xyd_fa5zoEU", "//www.youtube.com/embed/MKmrqcoCZ-M"],
                  procedure: "Lie on your back with your knees bent and feet flat on the floor, hip-width apart.\
                              Place your hands behind your head so your thumbs are behind your ears.\
                              Hold your elbows out to the sides but rounded slightly in.\
                              Gently pull your abdominals inward.\
                              Curl up and forward so that your head, neck, and shoulder blades lift off the floor.\
                              Hold for a moment at the top of the movement and then lower slowly back down."
              }),
              duration: 30
          });
          workout.exercises.push({
              details: new Exercise({
                  name: "squat",
                  title: "Squat",
                  description: "The squat is a compound, full body exercise that trains primarily the muscles of the thighs, hips, buttocks and quads.",
                  image: "img/squat.png",
                  videos: ["//www.youtube.com/embed/QKKZ9AGYTi4", "//www.youtube.com/embed/UXJrBgI2RxA"],
                  procedure: "Stand with your head facing forward and your chest held up and out.\
                              Place your feet shoulder-width apart or little wider. Extend your hands straight out in front of you.\
                              Sit back and down like you're sitting into a chair. Keep your head facing straight as your upper body bends forward a bit. Rather than allowing your back to round, let your lower back arch slightly as you go down.\
                              Lower down so your thighs are parallel to the floor, with your knees over your ankles. Press your weight back into your heels.\
                              Keep your body tight, and push through your heels to bring yourself back to the starting position."
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