import SwiftUI

struct AvatarPickerSheet: View {
    let onComplete: (UIImage?) -> Void
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 20) {
            Text("Choisir une photo")
                .font(.title2)
                .padding()

            HStack {
                Button("📷 Caméra") {
                    openPicker(.camera)
                }
                .disabled(!UIImagePickerController.isSourceTypeAvailable(.camera))

                Button("🖼 Bibliothèque") {
                    openPicker(.photoLibrary)
                }
            }
            .buttonStyle(.borderedProminent)
            .padding()

            Button("Annuler", role: .cancel) {
                dismiss()
            }
        }
        .presentationDetents([.medium])
    }

    private func openPicker(_ source: UIImagePickerController.SourceType) {
        
        onComplete(nil)
    }
}
