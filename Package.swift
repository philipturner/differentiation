// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "_Differentiation",
  products: [
    .library(
      name: "_Differentiation",
      targets: ["Differentiation"]),
  ],
  dependencies: [

  ],
  targets: [
    .target(
      name: "_Differentiation",
      dependencies: []),
    .target(
      name: "Differentiation",
      dependencies: ["_Differentiation"],
      swiftSettings: [.unsafeFlags(["-parse-stdlib"])]),

    // TODO: Make a separate module with each test for the specific compiler flags it needs
    // TODO: Include tests that require compilation of multiple modules
    .testTarget(
      name: "DifferentiationTests",
      dependencies: ["Differentiation"],
      exclude: [
        // Crashes on the Xcode 13.3.1 toolchain
        "compiler_crashers_fixed/sr13933-vjpcloner-apply-multiple-consuming-users.swift",
      ],
      sources: [
        "DifferentiationTests.swift",
        "compiler_crashers_fixed/rdar71191415-nested-differentiation-of-extension-method-optimized.swift",
        "compiler_crashers_fixed/rdar71319547-generated-decls-shall-not-be-resilient.swift",
        "compiler_crashers_fixed/rdar74087329-debug-scope-trampoline-blocks.swift",
        "compiler_crashers_fixed/rdar84716758-differentiable-protocol-witness-missing-requirements.swift",
        "compiler_crashers_fixed/sr12548-siloptimizer-rewrite-partial-apply-convention-method.swift",
        "compiler_crashers_fixed/sr12559-derivative-attr-type-checking-parse-stdlib.swift",
        "compiler_crashers_fixed/sr12641-silgen-immutable-address-use-verification-failure.swift",
        "compiler_crashers_fixed/sr12642-differentiable-derivation-redeclared-property.swift",
        "compiler_crashers_fixed/sr12650-noderivative-parameter-type-mangling.swift",
        "compiler_crashers_fixed/sr12656-differentiation-opaque-result-type.swift",
        "compiler_crashers_fixed/sr12744-unhandled-pullback-indirect-result.swift",
        "compiler_crashers_fixed/sr12886-sr12887-vjp-emitter-definite-initialization.swift",
        "compiler_crashers_fixed/sr13305-noderivative-inout-parameter.swift",
        "compiler_crashers_fixed/sr13411-tangent-value-category-mismatch.swift",
        "compiler_crashers_fixed/sr13865-library-evolution-mode-crasher-property-differentiation.swift",
        "compiler_crashers_fixed/sr14240-symbol-in-ir-file-not-tbd-file.swift",
        "compiler_crashers_fixed/sr14290-missing-debug-scopes-in-pullback-trampoline.swift",
        "compiler_crashers_fixed/sr14625-over-consume-in-subset-parameters-thunk.swift",
        "compiler_crashers_fixed/sr15205-diff-capture.swift",
        "compiler_crashers_fixed/sr15566-vardecl-adjoint-values.swift",
        // TODO: Reproduce the correct conditions for SR-15849 to trigger a crash
        "compiler_crashers_fixed/sr15849-mutating-functions-with-control-flow.swift",
        "compiler_crashers_fixed/sr15891-inout-adjoint-param-idx.swift",
        "compiler_crashers_fixed/tf1160-derivative-usable-from-inline-mismatch.swift",
        "compiler_crashers_fixed/tf1180-silgen-vtable-method-does-not-appear.swift",
        "compiler_crashers_fixed/tf1232-autodiff-generated-declaration-mangling.swift",
        "compiler_crashers_fixed/tf1315-pullback-subset-parameter-thunk-generation.swift",
      ])
  ]
)



















