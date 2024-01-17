import 'package:backend_training/models/note_model.dart';
import 'package:flutter/material.dart';

class NoteItem extends StatelessWidget {
  NoteItem({
   required this.noteModel
  });
NoteModel noteModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      //make the card in top of the screen

      //decrese height of card

      color: Color.fromARGB(255, 255, 251, 251),
      shadowColor: Colors.grey.shade300,
      elevation: 5,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/note.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  noteModel.title!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  noteModel.body!,
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color.fromARGB(255, 93, 90, 90),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
