/*
  ==============================================================================

    This file was auto-generated!

    It contains the basic framework code for a JUCE plugin editor.

  ==============================================================================
*/

#pragma once

#include "../JuceLibraryCode/JuceHeader.h"
#include "PluginProcessor.h"

//==============================================================================
/**
*/
class Itapdsession02plugin01AudioProcessorEditor  : public AudioProcessorEditor
{
public:
    Itapdsession02plugin01AudioProcessorEditor (Itapdsession02plugin01AudioProcessor&);
    ~Itapdsession02plugin01AudioProcessorEditor();

    //==============================================================================
    void paint (Graphics&) override;
    void resized() override;

private:
    // This reference is provided as a quick way for your editor to
    // access the processor object that created it.
    Itapdsession02plugin01AudioProcessor& processor;

    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR (Itapdsession02plugin01AudioProcessorEditor)
};
