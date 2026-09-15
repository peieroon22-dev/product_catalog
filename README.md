# Product Catalog App

A Flutter Product Catalog application developed for the Neurogine Junior Mobile Developer technical assessment.
The application uses the free DummyJSON API to retrieve and display product information.

## Features

### Required

* Product list with title, thumbnail, and price
* Pagination using the `skip` parameter
* Product detail with images, title, price, rating, and description
* Loading, error, empty, and success states
* Error state with Retry button
* Debounced product search
* Separation of data, state management, and UI

### Bonus

* Pull-to-refresh
* Network image loading placeholder
* Network image error handling
* Product image gallery

## Tech Stack

* Flutter / Dart
* Flutter Bloc / Cubit
* HTTP
* Easy Debounce
* Cached Network Image
* DummyJSON API

## Project Structure

The application is organized into the following folders:

* **models/** — contains the Product data model.
* **services/** — handles communication with the DummyJSON API.
* **cubits/** — manages product states and application logic using Cubit.
* **screens/** — contains the product list and product detail UI.
* **main.dart** — initializes the application and provides the ProductCubit.

## Architecture

The project separates responsibilities into three main areas:

* **Model** — `Product` represents the product data received from the API.
* **Service** — `ApiService` handles API requests and converts JSON responses into `Product` objects.
* **Cubit / UI** — `ProductCubit` manages application state, while the screens are responsible for displaying the UI.

I chose Cubit for state management because I wanted to separate application logic from the UI. I initially considered `setState` because it was more familiar to me, but after researching Cubit, I chose it to keep the product loading, pagination, search, and error handling logic organized.


## Running the Application

### Requirements

* Flutter SDK
* Dart SDK
* Android Studio / Android Emulator or another Flutter-supported device

### Setup

```bash
git clone https://github.com/peieroon22-dev/product_catalog.git
cd product_catalog
flutter pub get
flutter run
```

## AI Assistance

AI assistance was used as a learning and debugging aid during development.

I used ChatGPT to:

* Research and understand Cubit and state management, as I had limited prior experience with Cubit.
* Clarify unfamiliar Flutter concepts and implementation approaches.
* Help identify and debug issues encountered during development.