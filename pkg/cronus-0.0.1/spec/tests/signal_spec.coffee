Signal = require "cronus/signal"

fxns =
  fxn1 : (arg1 = null)-> return arg1
  fxn2 : (arg1 = null)-> return arg1

describe "Signal", ->
  signal = null

  beforeEach ->
    signal = new Signal()

  it "can add listeners", ->
    signal.add(fxns.fxn1)
    expect(signal.listeners.length).toEqual 1
    expect(signal.listeners[0]).toEqual fxns.fxn1

  it "can add listeners to be run only once", ->
    signal.add(fxns.fxn1)
    signal.addOnce(fxns.fxn2)
    expect(signal.listeners.length).toEqual 2
    signal.dispatch()
    expect(signal.listeners.length).toEqual 1

  it "can remove listeners", ->
    signal.add(fxns.fxn1)
    signal.remove(fxns.fxn1)
    expect(signal.listeners.length).toEqual 0

  it "can schedule listeners to be removed if dispatch is being run", ->
    # this prevents getting "undefined" listeners when a listener is removed before dispatch is finished
    selfRemover = ->
      signal.remove(selfRemover)
      expect(signal.listeners.length).toEqual 2
    signal.add(selfRemover)
    signal.add(fxns.fxn1)
    signal.dispatch()
    expect(signal.listeners.length).toEqual 1

  it "can get the number of current listeners", ->
    signal.add(fxns.fxn1)
    expect(signal.numListeners()).toEqual 1

  it "can dispatch a call to all listeners", ->
    spyOn(fxns, "fxn1")
    spyOn(fxns, "fxn2")
    signal.add(fxns.fxn1)
    signal.add(fxns.fxn2)
    signal.dispatch()
    expect(fxns.fxn1).toHaveBeenCalled()
    expect(fxns.fxn2).toHaveBeenCalled()

  it "can dispatch a call to all listeners with arguments", ->
    spyOn(fxns, "fxn1")
    spyOn(fxns, "fxn2")
    signal.add(fxns.fxn1)
    signal.add(fxns.fxn2)
    signal.dispatch("hello")
    expect(fxns.fxn1).toHaveBeenCalledWith("hello")
    expect(fxns.fxn2).toHaveBeenCalledWith("hello")
