should = require 'should'
{ Processor } = require '../src/processor'
{ verify, stub } = require './spec_helper'
{ Calculator } = require '../slim/fixtures/calculator'

describe 'making suts', ->

  decaf = new Processor()
  stub decaf, 'reply'

  it 'should make a Calculator', ->

    decaf.modules = [ require '../slim/fixtures/calculator' ]
    decaf.process [ '42', 'make', 'stuff', 'Calculator' ]

    verify decaf.sut instanceof Calculator