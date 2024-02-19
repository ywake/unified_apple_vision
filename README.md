# unified_apple_vision 🍎

[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)
[![Pub Version](https://img.shields.io/pub/v/unified_apple_vision)](https://pub.dev/packages/unified_apple_vision)

A plugin for using [Apple Vision Framework](https://developer.apple.com/documentation/vision) with Flutter, designed to integrate multiple APIs into one plugin and process multiple analysis requests at once.

## Features ⚙️ & Requirements 🧩

Status: ✅ Complete ⚠️ Problematic 👨‍💻 In Progress ❌ Not Yet

> [!IMPORTANT]  
> If you have a request, please make an [issue](https://github.com/ywake/unified_apple_vision/issues).

| Vision API | Request | Status | iOS | macOS | description |
|------------|---------|:------:|:---:|:-----:|-------------|
| [Still Image Analysis](https://developer.apple.com/documentation/vision/detecting_objects_in_still_images) | [Classify Image](https://developer.apple.com/documentation/vision/vnclassifyimagerequest) | ❌ | 13.0+ | 10.15+ | A request to classify an image. |
|| [Generate Image Feature Print](https://developer.apple.com/documentation/vision/vngenerateimagefeatureprintrequest) | ❌ | 13.0+ | 10.15+ | An image-based request to generate feature prints from an image. |
||||||
| [Image Sequence Analysis](https://developer.apple.com/documentation/vision/applying_matte_effects_to_people_in_images_and_video) | [Generate Person Segmentation](https://developer.apple.com/documentation/vision/vngeneratepersonsegmentationrequest) | ❌ | 15.0+ | 12.0+ | Produces a matte image for a person it finds in the input image. |
|| [Generate Person Instance Mask](https://developer.apple.com/documentation/vision/vngeneratepersoninstancemaskrequest) | ❌ | 17.0+ | 14.0+ | Produces a mask of individual people it finds in the input image. |
|| [Detect Document Segmentation](https://developer.apple.com/documentation/vision/vndetectdocumentsegmentationrequest) | ❌ | 15.0+ | 12.0+ | Detects rectangular regions that contain text in the input image. |
||||||
| [Saliency Analysis](https://developer.apple.com/documentation/vision/cropping_images_using_saliency) | [Generate Attention Based Saliency Image](https://developer.apple.com/documentation/vision/vngenerateattentionbasedsaliencyimagerequest) | ❌ | 13.0+ | 10.15+ | Produces a heat map that identifies the parts of an image most likely to draw attention. |
|| [Generate Objectness Based Saliency Image](https://developer.apple.com/documentation/vision/vngenerateobjectnessbasedsaliencyimagerequest) | ❌ | 13.0+ | 10.15+ | Generates a heat map that identifies the parts of an image most likely to represent objects. |
|||||||
| [Object Tracking](https://developer.apple.com/documentation/vision/tracking_multiple_objects_or_rectangles_in_video) | [Track Rectangle](https://developer.apple.com/documentation/vision/vntrackrectanglerequest) | ⚠️ | 11.0+ | 10.13+ | Tracks movement of a previously identified rectangular object across multiple images or video frames. |
|| [Track Object](https://developer.apple.com/documentation/vision/vntrackobjectrequest) | ⚠️ | 11.0+ | 10.13+ | Tracks the movement of a previously identified object across multiple images or video frames. |
|||||||
| [Rectangle Detection](https://developer.apple.com/documentation/vision/vndetectrectanglesrequest) | [Detect Rectangle](https://developer.apple.com/documentation/vision/vndetectrectanglesrequest) | ✅ | 11.0+ | 10.13+ | Finds projected rectangular regions in an image. |
|||||||
| [Face and Body Detection](https://developer.apple.com/documentation/vision/selecting_a_selfie_based_on_capture_quality) | [Detect Face Capture Quality](https://developer.apple.com/documentation/vision/vndetectfacecapturequalityrequest) | ❌ | 13.0+ | 10.15+ | Produces a floating-point number that represents the capture quality of a face in a photo. |
|| [Detect Face Landmarks](https://developer.apple.com/documentation/vision/vndetectfacelandmarksrequest) | ❌ | 11.0+ | 10.13+ | Finds facial features like eyes and mouth in an image. |
|| [Detect Face Rectangles](https://developer.apple.com/documentation/vision/vndetectfacerectanglesrequest) | ❌ | 11.0+ | 10.13+ | Finds faces within an image. |
|| [Detect Human Rectangles](https://developer.apple.com/documentation/vision/vndetecthumanrectanglesrequest) | ✅ | 13.0+ | 10.15+ | Finds rectangular regions that contain people in an image.|
|||||||
| [Body and Hand Pose Detection](https://developer.apple.com/documentation/vision/detecting_human_body_poses_in_images) | [Detect Human Body Pose](https://developer.apple.com/documentation/vision/vndetecthumanbodyposerequest) | ❌ | 14.0+ | 11.0+ | Detects a human body pose. |
|| [Detect Human Hand Pose](https://developer.apple.com/documentation/vision/vndetecthumanhandposerequest) | ❌ | 14.0+ | 11.0+ | Detects a human hand pose. |
|||||||
| [3D Body Pose Detection](https://developer.apple.com/documentation/vision/identifying_3d_human_body_poses_in_images) | [Detect Human Body Pose 3D](https://developer.apple.com/documentation/vision/vndetecthumanbodypose3drequest) | ❌ | 17.0+ | 14.0+ | Detects points on human bodies in three-dimensional space, relative to the camera. |
|||||||
| [Animal Detection](https://developer.apple.com/documentation/vision/vnrecognizeanimalsrequest) | [Recognize Animals](https://developer.apple.com/documentation/vision/vnrecognizeanimalsrequest) | ✅ | 13.0+ | 10.15+ | Recognizes animals in an image. (Now only dogs and cats are supported.) |
|||||||
| [Animal Body Pose Detection](https://developer.apple.com/documentation/vision/detecting_animal_body_poses_with_vision) | [Detect Animal Body Pose](https://developer.apple.com/documentation/vision/vndetectanimalbodyposerequest) | ❌ | 17.0+ | 14.0+ | Detects an animal body pose. |
|||||||
| [Trajectory Detection](https://developer.apple.com/documentation/vision/identifying_trajectories_in_video) | [Detect Trajectories](https://developer.apple.com/documentation/vision/vndetecttrajectoriesrequest) | ❌ | 14.0+ | 11.0+ | Detects the trajectories of shapes moving along a parabolic path. |
|||||||
| [Contour Detection](https://developer.apple.com/documentation/vision/vndetectcontoursrequest) | [Detect Contours](https://developer.apple.com/documentation/vision/vndetectcontoursrequest) | ❌ | 14.0+ | 11.0+ | Detects the contours of the edges of an image. |
|||||||
| [Optical Flow](https://developer.apple.com/documentation/vision/vngenerateopticalflowrequest) | [Generate Optical Flow](https://developer.apple.com/documentation/vision/vngenerateopticalflowrequest) | ❌ | 14.0+ | 11.0+ | Generates directional change vectors for each pixel in the targeted image. |
|| [Track Optical Flow](https://developer.apple.com/documentation/vision/vntrackopticalflowrequest) | ❌ | 17.0+ | 14.0+ | Determines the direction change of vectors for each pixel from a previous to current image. |
|||||||
| [Barcode Detection](https://developer.apple.com/documentation/vision/vndetectbarcodesrequest) | [Detect Barcodes](https://developer.apple.com/documentation/vision/vndetectbarcodesrequest) | ✅ | 11.0+ | 10.13+ | Detects barcodes in an image. |
|||||||
| [Text Detection](https://developer.apple.com/documentation/vision/vndetecttextrectanglesrequest) | [Detect Text Rectangles](https://developer.apple.com/documentation/vision/vndetecttextrectanglesrequest) | ✅ | 11.0+ | 10.13+ | Finds regions of visible text in an image. |
|||||||
| [Text Recognition](https://developer.apple.com/documentation/vision/recognizing_text_in_images) | [Recognize Text](https://developer.apple.com/documentation/vision/vnrecognizetextrequest) | ✅ | 13.0+ | 10.15+ | Finds and recognizes text in an image. |
|||||||
| [Horizon Detection](https://developer.apple.com/documentation/vision/vndetecthorizonrequest) | [Detect Horizon](https://developer.apple.com/documentation/vision/vndetecthorizonrequest) | ❌ | 11.0+ | 10.13+ | Determines the horizon angle in an image. |
|||||||
| [Image Alignment](https://developer.apple.com/documentation/vision/aligning_similar_images) | [Translational Image Registration](https://developer.apple.com/documentation/vision/vntranslationalimageregistrationrequest) | ❌ | 11.0+ | 10.13+ | Determines the affine transform necessary to align the content of two images. |
|| [Track Translational Image Registration](https://developer.apple.com/documentation/vision/vntracktranslationalimageregistrationrequest) | ❌ | 17.0+ | 14.0+ | An image analysis request, as a stateful request you track over time, that determines the affine transform necessary to align the content of two images. |
|| [Homographic Image Registration](https://developer.apple.com/documentation/vision/vnhomographicimageregistrationrequest) | ❌ | 11.0+ | 10.13+ | Determines the perspective warp matrix necessary to align the content of two images. |
|| [Track Homographic Image Registration](https://developer.apple.com/documentation/vision/vntrackhomographicimageregistrationrequest) | ❌ | 17.0+ | 14.0+ | An image analysis request, as a stateful request you track over time, that determines the perspective warp matrix necessary to align the content of two images. |
|||||||
| [Image Background Removal](https://developer.apple.com/documentation/vision/applying_visual_effects_to_foreground_subjects) | [Generate Foreground Instance Mask](https://developer.apple.com/documentation/vision/vngenerateforegroundinstancemaskrequest) | ❌ | 17.0+ | 14.0+ | Generates an instance mask of noticable objects to separate from the background. |

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
vision.analyze(
  image: input,
  requests: [
    // add requests you wish to perform
    VisionRecognizeTextRequest(
      onResults: (results) {
        final observations = results.ofRecognizeTextRequest; // get casted results
        // some action
      },
    ),
  ],
);
```

### [Documents 📘](doc/README.md)

## Contributing 🤝
Contributions are welcome! Please feel free to submit a Pull Request.

### Adding New Request or Observation
If you want to add a new request or observation class, you can use the `tools.py` script to generate the boilerplate code for you.

```bash
python3 tools.py request --name VNDetectRectanglesRequest --ios 11.0 --macos 10.13
python3 tools.py observation --name VNRectangleObservation --extends VNDetectedObjectObservation
```

## License 📜
This project is licensed under the MIT License - see the [LICENSE](https://github.com/ywake/unified_apple_vision/blob/main/LICENSE) file for details.
