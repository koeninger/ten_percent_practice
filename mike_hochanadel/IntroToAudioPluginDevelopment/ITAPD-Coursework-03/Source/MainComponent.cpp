/*
  ==============================================================================

    This file was auto-generated!

  ==============================================================================
*/

#include "MainComponent.h"

//==============================================================================
MainComponent::MainComponent()
{
    setSize (400, 400);
}

MainComponent::~MainComponent()
{
}

//==============================================================================
void MainComponent::paint (Graphics& g)
{
    // (Our component is opaque, so we must completely fill the background with a solid colour)
    g.fillAll (Colours::purple);
    g.setFont (Font (16.0f));
    g.setColour (Colours::white);
    g.drawText ("Learning JUCE", getLocalBounds(), Justification::centred, true);
    
    g.setFont(Font("Comic Sans", 20.0f, Font::bold));
    g.drawText("Huzzah!", 20, 40, 100, 40, Justification::centred, true);
    
    g.setColour(Colours::green);
    g.drawLine(10, 300, 390, 300);
    const float myDashLength[] = {4,5,6,7};
    g.drawDashedLine(Line<float>(50.0f,50.0f,350.0f,350.0f),&myDashLength[0],4,3.4f,3);
    
    g.setColour(Colours::sandybrown);
    g.drawRect(300,120,200,170,3);
    
    Rectangle<float> house (10,10,150,125);
    g.setColour(Colours::blueviolet);
    g.fillCheckerBoard(house, 30,10,Colours::red, Colours::green);
    
    g.setColour(Colours::mediumvioletred);
    g.drawRoundedRectangle(200, 210, 35, 30, 3, 2);
    
    g.setColour(Colours::darkgrey);
    Rectangle<float> shed (30.5f, 12.1f, 170.7f, 130.4f);
    g.fillRoundedRectangle(shed,6.4f);
    
    g.setColour(Colours::yellow);
    g.drawEllipse(getWidth() - 70, 10, 60, 60, 3);
    
    Point<float> hole (50.4f, 375.34f);
    g.setColour(Colours::black);
    drawSmartEllipse(g,hole,10.4f,2);
    
    g.setColour(Colours::rosybrown);
    
    Path roof;
    roof.addTriangle(150,110,500,110,400,70);
    g.fillPath(roof);
    
}

void MainComponent::drawSmartEllipse(Graphics& g, Point<float> point, float radius, float thickness)
{
    g.drawEllipse(point.getX(), point.getY(), radius, radius, thickness);
}

void MainComponent::resized()
{
    // This is called when the MainComponent is resized.
    // If you add any child components, this is where you should
    // update their positions.
}
