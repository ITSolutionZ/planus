import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/community_viewmodel.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CommunityViewModel(),
      child: Scaffold(
        backgroundColor: const Color(0xFFFDF3E7),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'コミュニティー',
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                icon: const Icon(Icons.notifications, color: Colors.black),
                onPressed: () {}),
            IconButton(
                icon: const Icon(Icons.person, color: Colors.black),
                onPressed: () {}),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<CommunityViewModel>(
            builder: (context, viewModel, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchBar(viewModel),
                  const SizedBox(height: 16),
                  _buildTagFilter(viewModel),
                  const SizedBox(height: 16),
                  _buildGroupSection('新規グループ', viewModel),
                  const SizedBox(height: 16),
                  _buildGroupSection('友達が参加中', viewModel),
                  const Spacer(),
                  _buildCreateGroupButton(context),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(CommunityViewModel viewModel) {
    return TextField(
      onChanged: viewModel.updateSearchQuery,
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () {},
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildTagFilter(CommunityViewModel viewModel) {
    final tags = ['募集', '医学部学習', '英語コーティング', '専門講座', '数学', 'キャッシュフロー'];
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: tags.map((tag) {
        final isSelected = viewModel.selectedTags.contains(tag);
        return ChoiceChip(
          label: Text(tag),
          selected: isSelected,
          onSelected: (_) => viewModel.toggleTag(tag),
          selectedColor: Colors.orange.shade200,
          backgroundColor: Colors.grey.shade200,
        );
      }).toList(),
    );
  }

  Widget _buildGroupSection(String title, CommunityViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(onPressed: () {}, child: const Text('more')),
          ],
        ),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    width: 120,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/group_image_$index.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('グループ ${index + 1}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        const Text('#タグ', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCreateGroupButton(BuildContext context) {
    return Card(
      color: Colors.orange.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: const Icon(Icons.add, color: Colors.orange),
        title: const Text(
          '新規グループ設立',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onTap: () {
          // 그룹 생성 페이지로 이동
        },
      ),
    );
  }
}
