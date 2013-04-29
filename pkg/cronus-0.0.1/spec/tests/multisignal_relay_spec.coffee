Signal = require "cronus/signal"
MultiSignalRelay = require "cronus/multi_signal_relay"

fxns =
  fxn1 : (arg1 = null)-> return arg1
  fxn2 : (arg1 = null)-> return arg1


describe "MultiSignalRelay", ->
  signalOne = null
  signalTwo = null
  multiSignalRelay = null

  beforeEach ->
    signalOne = new Signal()
    signalTwo = new Signal()
    multiSignalRelay = new MultiSignalRelay([ signalOne, signalTwo ])

  it "can relay a message from one of multiple signals", ->
    spyOn(fxns, "fxn1")
    spyOn(fxns, "fxn2")
    multiSignalRelay.add(fxns.fxn1)
    signalOne.dispatch("hello")
    expect(fxns.fxn1).toHaveBeenCalledWith("hello")
    multiSignalRelay.add(fxns.fxn2)
    signalTwo.dispatch("goodbye")
    expect(fxns.fxn1).toHaveBeenCalledWith("goodbye")
    expect(fxns.fxn2).toHaveBeenCalledWith("goodbye")
