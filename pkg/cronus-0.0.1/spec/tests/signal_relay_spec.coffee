Signal = require "cronus/signal"
SignalRelay = require "cronus/signal_relay"

fxns =
  fxn1 : (arg1 = null)-> return arg1
  fxn2 : (arg1 = null)-> return arg1


describe "SignalRelay", ->
  signal = null
  signalRelay = null

  beforeEach ->
    signal = new Signal()
    signalRelay = new SignalRelay(signal)

  it "can relay a signal", ->
    spyOn(fxns, "fxn1")
    signalRelay.add(fxns.fxn1)
    signal.dispatch("hello")
    expect(fxns.fxn1).toHaveBeenCalledWith("hello")