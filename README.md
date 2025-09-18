# 🚗 Autonomous Car Project (AVR Assembly)

This project demonstrates the design and implementation of an **autonomous car** that can follow a line using a reflectance sensor and avoid obstacles using an ultrasonic sensor. The car is controlled by an **AVR64DU32 microcontroller** programmed entirely in **AVR Assembly** and built on a custom chassis with motors and a motor driver.

---

## 🔧 Features
- **Line Following:**  
  Uses a QTR-8A reflectance sensor array to detect and follow a black tape track.  
- **Motor Control with PWM:**  
  Dual-slope (phase-correct) PWM generation controls motor speed for smooth operation.  
- **Turning Logic:**  
  Conditional branching in AVR assembly adjusts motor duty cycles for left and right turns.  
- **Sensor Integration:**  
  - Reflectance sensor array for line tracking  
  - Ultrasonic sensor for obstacle detection (future expansion)  
- **Motor Driver (TB6612):**  
  Controls two independent DC motors with directional and PWM inputs.  

---

## ⚙️ Hardware Components
- **AVR64DU32 Microcontroller** – 8-bit MCU, 64 KB flash, 24 MHz  
- **QTR-8A Reflectance Sensor Array** – line-following capability  
- **TB6612 Motor Driver** – dual DC motor control  
- **DC Motors + Chassis** – car locomotion  
- **9V Battery Pack** – power supply  
- **MPLAB X IDE** – programming and debugging environment  

---

## 🛠️ Code Overview
- **PWM Setup:** Configures dual-slope PWM signals to drive motors at 50 Hz.  
- **Main Loop Logic:** Continuously reads reflectance sensor values and branches execution to go straight, turn left, or turn right.  
- **Turning Routines:** Adjust duty cycles of left and right motors for pivot-style steering.  

---

## 📊 Results
- Successfully completed laps around a taped track.  
- Handled both left and right turns reliably.  
- Stable line following achieved through calibrated motor speeds.  
- Improvement idea: Increase distance between sensor and track surface to reduce false readings.  

---

## 🚀 Future Improvements
- Integrate ultrasonic sensor for **obstacle avoidance**.  
- Expand control logic for smoother navigation.  
- Improve chassis design for stability.  
- Add modular code structure for easier upgrades.  

---

## 📖 References
- Microchip AVR64DU32 Datasheet  
- Pololu QTR-8A Reflectance Sensor Array Documentation  
- Adafruit TB6612 Motor Driver Documentation  

---
