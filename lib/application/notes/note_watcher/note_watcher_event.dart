part of 'note_watcher_bloc.dart';

@freezed
abstract class NoteWatcherEvent with _$NoteWatcherEvent {
  const factory NoteWatcherEvent.watchAllstarted() = _WatchAllStarted;
  const factory NoteWatcherEvent.watchUncompletedstarted() =
      _WatchUncompletedStarted;
  const factory NoteWatcherEvent.notesReceived(
    Either<NoteFailure, KtList<Note>> failureOrNotes,
  ) = _NotesReceived;
}
