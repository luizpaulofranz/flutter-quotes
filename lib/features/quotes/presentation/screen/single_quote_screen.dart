import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/core/components/custom_app_bar.dart';
import 'package:quotes/features/quotes/domain/entities/quote.dart';
import 'package:quotes/features/quotes/presentation/bloc/single_quote/single_quote_bloc.dart';
import 'package:quotes/features/quotes/presentation/bloc/single_quote/single_quote_event.dart';

class SingleQuotesScreen extends StatefulWidget {
  final Quote quote;

  SingleQuotesScreen({super.key, required this.quote});

  @override
  State<SingleQuotesScreen> createState() => _SingleQuotesScreenState();
}

class _SingleQuotesScreenState extends State<SingleQuotesScreen> {
  final _formKey = GlobalKey<FormState>();

  final _isEditing = ValueNotifier<bool>(false);

  late final TextEditingController _authorController;
  late final TextEditingController _quoteController;

  @override
  void initState() {
    super.initState();
    _authorController = TextEditingController(text: widget.quote.author);
    _quoteController = TextEditingController(text: widget.quote.content);
  }

  @override
  void dispose() {
    _authorController.dispose();
    _quoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "${widget.quote.author}'s quote"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ValueListenableBuilder(
            valueListenable: _isEditing,
            builder: (_, bool isEditing, __) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _authorController,
                      readOnly: !isEditing,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Author',
                      ),
                    ),
                    TextFormField(
                      controller: _quoteController,
                      readOnly: !isEditing,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Quote',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(
                          width: 80,
                          child: OutlinedButton(
                            onPressed: () => _isEditing.value = !isEditing,
                            child: isEditing
                                ? const Text("Cancel")
                                : const Text("Edit"),
                          ),
                        ),
                        const SizedBox(width: 10),
                        FilledButton(
                          onPressed: isEditing
                              ? () {
                                  context.read<SingleQuoteBloc>().add(
                                        UpdateQuote(
                                          Quote(
                                            id: widget.quote.id,
                                            author: _authorController.text,
                                            content: _quoteController.text,
                                          ),
                                        ),
                                      );
                                  _isEditing.value = false;
                                  // close keyboard
                                  FocusScope.of(context).unfocus();
                                }
                              : null,
                          child: const Text("Save"),
                        ),
                        const Spacer(),
                        FilledButton(
                          style: FilledButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 160, 37, 29)),
                          onPressed: () {
                            context.read<SingleQuoteBloc>().add(
                                  DeleteQuote(widget.quote),
                                );
                            Navigator.of(context).pop();
                          },
                          child: const Text("Delete"),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
