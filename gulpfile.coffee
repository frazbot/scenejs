gulp		= require "gulp"
coffee		= require "gulp-coffee"
watch		= require "gulp-watch"
plumber		= require "gulp-plumber"

gulp.task('default', ['coffee'])

gulp.task('coffee', ->
	gulp
		.src("coffee/**/*.coffee")
		.pipe(watch())
		.pipe(plumber())
		.pipe(coffee({sourceMap: true}))
		.pipe(gulp.dest("js"))
)