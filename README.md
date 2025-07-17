# Wajibika: A Community Environmental Reporting App

## Project Overview

Wajibika (Swahili for "take responsibility") is a mobile application developed with Flutter, designed to empower communities to actively participate in environmental conservation by reporting hazards. Users can easily document environmental issues by either capturing a new photo or selecting one from their gallery, adding a brief description, categorizing the hazard, and submitting the report. This initiative aims to foster community action and contribute directly to sustainable development.

## Sustainable Development Goal (SDG) Alignment

This project directly contributes to **SDG 11: Sustainable Cities and Communities**, specifically target 11.6: "By 2030, reduce the adverse per capita environmental impact of cities, including by paying special attention to air quality and municipal and other waste management." By enabling citizens to report environmental hazards, Wajibika facilitates better waste management, pollution control, and overall urban environmental health.

## Features

* **Hazard Reporting:**
    * Capture photos of environmental hazards using the device camera.
    * Select existing photos from the device gallery.
    * Add a concise description of the hazard.
    * Categorize the hazard (e.g., illegal dumping, water pollution, air pollution, deforestation).
    * Submit reports with location data (if available and permitted).
* **User Authentication:** Secure user registration and login.
* **Wajibika Points System:** An incentive program where users earn points for each valid report they submit, encouraging active participation.
* **Report Tracking:** Users can view the status and history of their submitted reports.

## Technology Stack

* **Frontend:**
    * **Flutter:** Cross-platform mobile application development framework.
    * **Bloc (Business Logic Component):** State management pattern for robust and scalable application architecture.
* **Backend:**
    * **Node.js:** Powers the backend API, handling user authentication and report submissions.
    * **JWT (JSON Web Tokens):** Used for secure authentication and authorization between the client and the Node.js backend.
* **Database & Storage:**
    * **Supabase:** Utilized for efficient and scalable image storage associated with hazard reports.
