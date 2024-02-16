# unified_apple_vision 🍎

[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)
[![Pub Version](https://img.shields.io/pub/v/unified_apple_vision)](https://pub.dev/packages/unified_apple_vision)

A plugin for using [Apple Vision Framework](https://developer.apple.com/documentation/vision) with Flutter, designed to integrate multiple APIs into one plugin and process multiple analysis requests at once.

## Features ⚙️ & Requirements 🧩

Status: ✅ Complete ⚠️ Problematic 👨‍💻 In Progress ❌ Not Yet

| Vision API | Request | Status | iOS | macOS |
|------------|---------|:------:|:---:|:-----:|
||||||
| [Saliency Analysis](https://developer.apple.com/documentation/vision/cropping_images_using_saliency) | [Generate Attention Based Saliency Image](https://developer.apple.com/documentation/vision/vngenerateattentionbasedsaliencyimagerequest) | ❌ | 13.0+ | 10.15+ |
|| [Generate Objectness Based Saliency Image](https://developer.apple.com/documentation/vision/vngenerateobjectnessbasedsaliencyimagerequest) | ❌ | 13.0+ | 10.15+ |
||||||
| [Object Tracking](https://developer.apple.com/documentation/vision/tracking_multiple_objects_or_rectangles_in_video) | [Track Rectangle](https://developer.apple.com/documentation/vision/vntrackrectanglerequest) | ⚠️ | 11.0+ | 10.13+ |
|| [Track Object](https://developer.apple.com/documentation/vision/vntrackobjectrequest) | ⚠️ | 11.0+ | 10.13+ |
||||||
| [Rectangle Detection](https://developer.apple.com/documentation/vision/vndetectrectanglesrequest) | [Detect Rectangle](https://developer.apple.com/documentation/vision/vndetectrectanglesrequest) | ✅ | 11.0+ | 10.13+ |
||||||
| [Face and Body Detection](https://developer.apple.com/documentation/vision/selecting_a_selfie_based_on_capture_quality) | [Detect Face Capture Quality](https://developer.apple.com/documentation/vision/vndetectfacecapturequalityrequest) | ❌ | 13.0+ | 10.15+ |
|| [Detect Face Landmarks](https://developer.apple.com/documentation/vision/vndetectfacelandmarksrequest) | ❌ | 11.0+ | 10.13+ |
|| [Detect Face Rectangles](https://developer.apple.com/documentation/vision/vndetectfacerectanglesrequest) | ❌ | 11.0+ | 10.13+ |
|| [Detect Human Rectangles](https://developer.apple.com/documentation/vision/vndetecthumanrectanglesrequest) | ❌ | 13.0+ | 10.15+ |
||||||
| [Body and Hand Pose Detection](https://developer.apple.com/documentation/vision/detecting_human_body_poses_in_images) | [Detect Human Body Pose](https://developer.apple.com/documentation/vision/vndetecthumanbodyposerequest) | ❌ | 14.0+ | 11.0+ |
|| [Detect Human Hand Pose](https://developer.apple.com/documentation/vision/vndetecthumanhandposerequest) | ❌ | 14.0+ | 11.0+ |
||||||
| [3D Body Pose Detection](https://developer.apple.com/documentation/vision/identifying_3d_human_body_poses_in_images) | [Detect Human Body Pose 3D](https://developer.apple.com/documentation/vision/vndetecthumanbodypose3drequest) | ❌ | 17.0+ | 14.0+ |
||||||
| [Animal Detection](https://developer.apple.com/documentation/vision/vnrecognizeanimalsrequest) | [Recognize Animals](https://developer.apple.com/documentation/vision/vnrecognizeanimalsrequest)<br>(only dogs and cats...😓) | ✅ | 13.0+ | 10.15+ |
||||||
| [Animal Body Pose Detection](https://developer.apple.com/documentation/vision/detecting_animal_body_poses_with_vision) | [Detect Animal Body Pose](https://developer.apple.com/documentation/vision/vndetectanimalbodyposerequest) | ❌ | 17.0+ | 14.0+ |
||||||
| [Trajectory Detection](https://developer.apple.com/documentation/vision/identifying_trajectories_in_video) | [Detect Trajectories](https://developer.apple.com/documentation/vision/vndetecttrajectoriesrequest) | ❌ | 14.0+ | 11.0+ |
||||||
| [Contour Detection](https://developer.apple.com/documentation/vision/vndetectcontoursrequest) | [Detect Contours](https://developer.apple.com/documentation/vision/vndetectcontoursrequest) | ❌ | 14.0+ | 11.0+ |
||||||
| [Optical Flow](https://developer.apple.com/documentation/vision/vngenerateopticalflowrequest) | [Generate Optical Flow](https://developer.apple.com/documentation/vision/vngenerateopticalflowrequest) | ❌ | 14.0+ | 11.0+ |
|| [Track Optical Flow](https://developer.apple.com/documentation/vision/vntrackopticalflowrequest) | ❌ | 17.0+ | 14.0+ |
||||||
| [Barcode Detection](https://developer.apple.com/documentation/vision/vndetectbarcodesrequest) | [Detect Barcodes](https://developer.apple.com/documentation/vision/vndetectbarcodesrequest) | ❌ | 11.0+ | 10.13+ |
||||||
| [Text Detection](https://developer.apple.com/documentation/vision/vndetecttextrectanglesrequest) | [Detect Text Rectangles](https://developer.apple.com/documentation/vision/vndetecttextrectanglesrequest) | ✅ | 11.0+ | 10.13+ |
||||||
| [Text Recognition](https://developer.apple.com/documentation/vision/recognizing_text_in_images) | [Recognize Text](https://developer.apple.com/documentation/vision/vnrecognizetextrequest) | ✅ | 13.0+ | 10.15+ |
||||||
| [Horizon Detection](https://developer.apple.com/documentation/vision/vndetecthorizonrequest) | [Detect Horizon](https://developer.apple.com/documentation/vision/vndetecthorizonrequest) | ❌ | 11.0+ | 10.13+ |
||||||
| [Image Alignment](https://developer.apple.com/documentation/vision/aligning_similar_images) | [Translational Image Registration](https://developer.apple.com/documentation/vision/vntranslationalimageregistrationrequest) | ❌ | 11.0+ | 10.13+ |
|| [Track Translational Image Registration](https://developer.apple.com/documentation/vision/vntracktranslationalimageregistrationrequest) | ❌ | 17.0+ | 14.0+ |
|| [Homographic Image Registration](https://developer.apple.com/documentation/vision/vnhomographicimageregistrationrequest) | ❌ | 11.0+ | 10.13+ |
|| [Track Homographic Image Registration](https://developer.apple.com/documentation/vision/vntrackhomographicimageregistrationrequest) | ❌ | 17.0+ | 14.0+ |
||||||
| [Image Background Removal](https://developer.apple.com/documentation/vision/applying_visual_effects_to_foreground_subjects) | [Generate Foreground Instance Mask](https://developer.apple.com/documentation/vision/vngenerateforegroundinstancemaskrequest) | ❌ | 17.0+ | 14.0+ |

## Install 📦
Add this to your pubspec.yaml:

```yaml
unified_apple_vision: ^latest
```

## Usage 🕹

```dart
// initialize
final vision = UnifiedAppleVision();

// create input image
final input = VisionInputImage(
  bytes: image.bytes,
  size: image.size,
);

// analyze
final res = await vision.analyze(input, [
  // add requests you want to process
  const VisionRecognizeTextRequest(),
]);
```

### [Documents 📘](doc/README.md)

## License 📜
This project is licensed under the MIT License - see the [LICENSE](https://github.com/ywake/unified_apple_vision/blob/main/LICENSE) file for details.
