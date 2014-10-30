define [
	"util/Vendor"
	"vo/ImageVO"
	"display/DisplayObject"
	"display/render/BackgroundRender"
	"display/render/ImageRender"
], (Vendor,ImageVO,DisplayObject,BackgroundRender,ImageRender) ->

	class Sprite extends DisplayObject

		_image: null

		_renderEngine: null

		constructor: (image, options) ->

			super(options)

			@_image = new ImageVO(image,0,0,@_contentWidth,@_contentHeight)

			@element.className += " sprite"
			@element.style.overflow = "hidden"
			
			if options?.renderMethod?
				switch options.renderMethod
					when Sprite.RENDER_METHODS.background
						@_renderEngine = new BackgroundRender([@_image])
					when Sprite.RENDER_METHODS.image
						@_renderEngine = new ImageRender([@_image])
					else 
						@_renderEngine = new BackgroundRender([@_image])
			else
				@_renderEngine = new BackgroundRender([@_image])

			@element.appendChild(@_renderEngine.element)

			@_dirtyInternals = true
		
		#################################################################################
		# PUBLIC FUNCTIONS
		#################################################################################
		
		destroy: () ->
			@_image = null
			super()

		#################################################################################
		# PRIVATE/PROTECTED FUNCTIONS
		#################################################################################

		###
		Renders updates
		###
		_renderInternals: () ->
			if @_dirtyInternals
				@_renderEngine.render(@_image)
				@_dirtyInternals = false