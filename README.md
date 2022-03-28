# badger2040
Tools and applications for bulk/user population of Badger2040 assets &amp; firmware.

## Concept & Objective

The Pimoroni e-ink badge "Badger 2040" is being considered as a Furry Migration 2022 super-sponsor gift to fit in with the "Space" theme. This badge will either be loaded with attendee data in one of two ways;

### Objective 1: Preloading

One theory / approach is to preload all the Badger 2040 devices with the attendee Badge number, Attendee Name and some other static pre-determined information. This would be done in bulk before the "Badge Printing Party" for the convention. This would include the "FM" pin as the badge image. This solution is a "out of the box" experience to have a functional badge with their name on it, but would require them to go through the steps to change the fields and upload their own photo through a series of steps.

### Objective 2: WebApp Generation

Another approach is to put the "Badger 2040" device in as part of the attendees super sponsor bag, and provide a webApp for the attendee to populate the fields & image online, and given a file after to put on their badge. This offers additional flexibility and no need for the attendee to work with Python to load the data themselves via a set of complicated steps.

## Hardware

The badge sports a 2.9" black and white E Ink® display (296 x 128 pixels) powered by a RP2040 (Dual Arm Cortex M0+ running at up to 133Mhz with 264kB of SRAM), and 2MB of QSPI flash supporting XiP.


## Additional Reading / Sources

- [Badger 2040 Product Page](https://shop.pimoroni.com/products/badger-2040)
- [Getting Started: Badger 2040](https://learn.pimoroni.com/article/getting-started-with-badger-2040)
- [Stock Device Firmware](https://github.com/pimoroni/pimoroni-pico/releases)
   - [Examples Source Code](https://github.com/pimoroni/pimoroni-pico/tree/main/micropython/examples/badger2040) 
- [Thonny IDE](https://thonny.org/)
