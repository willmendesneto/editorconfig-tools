fs = require 'fs'
path = require 'path'
File = require 'fobject'
W = require 'when'

editorconfig = require './editorconfig'

class Rule
  ###*
   * The "official" name of the rule, according to the editorconfig spec.
   * @type {String}
  ###
  propertyName: ''

  ###*
   * The setting of the rule for the file being tested.
   * @type {String|Integer|Boolean}
  ###
  setting: undefined

  ###*
   * The file being tested.
   * @type {File}
  ###
  file: undefined

  ###*
   * Setup the Rule for a given filename so the other methods can be used.
   * @param {String} filename
  ###
  constructor: (filename) ->
    @editorconfig = editorconfig(filename)
    @setting = @editorconfig[@propertyName]
    @file = new File(filename)

  ###*
   * Fix the file so it matches the given editorconfig setting
   * @return {Promise}
  ###
  fix: ->

  ###*
   * Ensure that the file obeys the editorconfig setting. Throw an error if it
     doesn't.
   * @return {Promise}
  ###
  check: ->
    W.promise((resolve, reject, notify) =>
      resolve(
        if not @setting?
          null # the setting isn't defined, so we can't check it
        else
          @infer().then((detectedSetting) =>
            if detectedSetting isnt @setting
              throw new Error('invalid')
          )
      )
    )

  ###*
   * Determine the value of the setting based on the contents of the file.
   * @return {Promise} A promise for the value of the setting.
  ###
  infer: ->

module.exports = Rule