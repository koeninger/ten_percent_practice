/*
  ==============================================================================

    This file was auto-generated!

    It contains the basic framework code for a JUCE plugin editor.

  ==============================================================================
*/

#include "PluginProcessor.h"
#include "PluginEditor.h"

//==============================================================================
Itapdsession02plugin01AudioProcessorEditor::Itapdsession02plugin01AudioProcessorEditor (Itapdsession02plugin01AudioProcessor& p)
    : AudioProcessorEditor (&p), processor (p)
{
    // Make sure that before the constructor has finished, you've set the
    // editor's size to whatever you need it to be.
    setSize (400, 300);
    
    auto& params = processor.getParameters();
    AudioParameterFloat* gainParameter = (AudioParameterFloat*)params.getUnchecked(0);
    
    mGainControlSlider.setBounds(0,0,100,100);
    mGainControlSlider.setSliderStyle(Slider::SliderStyle::RotaryVerticalDrag);
    mGainControlSlider.setTextBoxStyle(Slider::NoTextBox, true, 0, 0);
    mGainControlSlider.setRange(gainParameter->range.start, gainParameter->range.end);
    mGainControlSlider.setValue(*gainParameter);
    mGainControlSlider.addListener(this);
    addAndMakeVisible(mGainControlSlider);
    
}

Itapdsession02plugin01AudioProcessorEditor::~Itapdsession02plugin01AudioProcessorEditor()
{
}

//==============================================================================
void Itapdsession02plugin01AudioProcessorEditor::paint (Graphics& g)
{
    // (Our component is opaque, so we must completely fill the background with a solid colour)
    g.fillAll (getLookAndFeel().findColour (ResizableWindow::backgroundColourId));

    g.setColour (Colours::white);
    g.setFont (15.0f);
    g.drawFittedText ("Hello World!", getLocalBounds(), Justification::centred, 1);
}

void Itapdsession02plugin01AudioProcessorEditor::resized()
{
    // This is generally where you'll want to lay out the positions of any
    // subcomponents in your editor..
}

void Itapdsession02plugin01AudioProcessorEditor::sliderValueChanged(Slider* slider)
{
    
    auto& params = processor.getParameters();
    if (slider == &mGainControlSlider) {
        AudioParameterFloat* gainParameter = (AudioParameterFloat*)params.getUnchecked(0);
        *gainParameter = mGainControlSlider.getValue();
        DBG(*gainParameter);
        DBG("Gain Slider changed");
    }
    DBG("Slider value changed");
}
