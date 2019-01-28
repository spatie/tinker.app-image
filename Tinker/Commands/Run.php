<?php

namespace App\Tinker\Commands;

use Psy\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;


class Run extends Command
{
    /**
     * {@inheritdoc}
     */
    protected function configure()
    {
        $this
            ->setName('run')
            ->setDefinition([])
            ->setDescription('Run app/helpers.php file');
    }

    /**
     * {@inheritdoc}
     */
    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $shell = $this->getApplication();

        $input = file_get_contents(base_path('tinker_buffer'));

        $shell->addInput($input);
    }
}
