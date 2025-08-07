import 'package:flutter/material.dart';
import 'package:tism/constants/colors.dart';

class PDFCoverGenerator extends StatelessWidget {
  final String title;
  final String type;
  final IconData icon;

  const PDFCoverGenerator({
    super.key,
    required this.title,
    required this.type,
    required this.icon,
  });

  Color _getTypeColor(String type) {
    switch (type) {
      case 'Guias':
        return Colors.blue[600]!;
      case 'Checklists':
        return Colors.green[600]!;
      case 'Manuais':
        return Colors.orange[600]!;
      case 'Artigos':
        return Colors.purple[600]!;
      default:
        return tismAqua;
    }
  }

  @override
  Widget build(BuildContext context) {
    final typeColor = _getTypeColor(type);
    
    return Container(
      width: 120,
      height: 160,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            typeColor,
            typeColor.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                type,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(
              icon,
              color: Colors.white,
              size: 40,
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'PDF',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}