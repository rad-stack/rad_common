export class ActionTextFileValidations {
  // Make sure to update VALID_ATTACHMENT_TYPES in rad_common if you add or remove any file types
  static VALID_ATTACHMENT_TYPES = [
    'application/msword',
    'application/pdf',
    'application/vnd.ms-excel',
    'application/vnd.ms-excel.sheet.macroenabled.12',
    'application/vnd.ms-outlook',
    'application/vnd.ms-powerpoint',
    'application/vnd.openxmlformats-officedocument.presentationml.presentation',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.template',
    'application/rtf',
    'application/x-iwork-pages-sffpages',
    'application/x-ole-storage',
    'application/x-secure-download',
    'application/x-zip-compressed',
    'application/zip',
    'application/vnd.apple.pages',
    'application/vnd.apple.keynote',
    'application/vnd.apple.numbers',
    'image/bmp',
    'image/gif',
    'image/heic',
    'image/tiff',
    'image/vnd.adobe.photoshop',
    'message/rfc822',
    'text/csv',
    'text/html',
    'text/plain',
    'image/png',
    'image/jpeg',
    'image/jpg',
    'image/webp',
    'video/x-msvideo',
    'video/mp4',
    'video/mpeg',
    'video/3gpp',
    'video/quicktime',
    'audio/mpeg',
    'audio/mp3',
    'audio/wav',
    'audio/wave',
    'audio/x-wav',
    'audio/aiff',
    'audio/x-aifc',
    'audio/x-aiff',
    'audio/mp4',
    'audio/x-gsm',
    'audio/ulaw'
  ];

  static setup() {
    document.addEventListener('trix-file-accept', async function (event) {
      const errors= [];

      if (!ActionTextFileValidations.VALID_ATTACHMENT_TYPES.includes(event.file.type)) {
        errors.push('Invalid file type');
      }

      const fileSizeMB = event.file.size / 1024 / 1024;
      if (fileSizeMB > 100) {
        errors.push('File size too large');
      }

      if (errors.length > 0) {
        event.preventDefault();
        alert(errors.join('\n'));
      }
    });
  }
}
